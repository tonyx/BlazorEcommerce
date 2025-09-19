namespace BlazorEcommerce.ServerFs.Services.CartService

open System
open System.IdentityModel.Tokens.Jwt
open System.Linq
open System.Security.Claims
open System.Security.Cryptography
open System.Threading.Tasks
open BlazorEcommerce.SharedFs.Models
open BlazorEcommerce.ServerFs.Services
open BlazorEcommerce.SharedFs
open Microsoft.AspNetCore.Http
open Microsoft.Extensions.Configuration
open Microsoft.IdentityModel.Tokens
open Sharpino
open Sharpino.CommandHandler
open Sharpino.EventBroker
open Sharpino.PgStorage
open Sharpino.StateView
open Sharpino.Storage
open FSharpPlus.Operators
open FsToolkit.ErrorHandling
open BlazorEcommerce.SharedFs.Aliases

type CartService (eventStore: IEventStore<string>, authService: IAuthService) =
    interface ICartService with
        member this.GetCartProducts(cartItems: List<CartItem>) =
            // let userId = authService.GetUserId()
            let resultQ =
                result
                    {
                        let! allProducts = StateView.getAllAggregateStates<Product, ProductEvents, string> eventStore
                        let allProducts = allProducts |>> snd
                        let productsFound =
                            cartItems
                            |> List.map (fun x -> allProducts |> List.tryFind (fun y -> y.Id = x.ProductId))
                            |> List.filter (fun x -> x.IsSome)
                            |> List.map (fun x -> x.Value)
                        
                        let! productVariants =
                            StateView.getAllAggregateStates<ProductVariant, ProductVariantEvents, string> eventStore
                        let productVariants = productVariants |>> snd
                        let productVariantsFound =
                            cartItems
                            |> List.map (fun x -> productVariants |> List.tryFind (fun y -> y.Id = x.ProductId))
                            |> List.filter (fun x -> x.IsSome)
                            |> List.map (fun x -> x.Value)
                        
                        let serviceResponse = ServiceResponse<List<CartProductResponse>>()
                        let productVariantsPerProduct =
                            productsFound
                            |> List.map
                                   (fun x -> (x,
                                        productVariantsFound
                                        |> List.filter (fun y -> y.ProductId = x.Id) |> List.tryHead
                                        )
                                   )
                        
                        let cartProducts =
                            productVariantsPerProduct
                            |> List.filter (fun (_, y) -> y.IsSome)
                            |> List.map (fun (x, y) ->
                                let cartProductResponse: CartProductResponse =
                                    {
                                        ProductId = x.Id
                                        Title = x.Title
                                        ProductTypeId = y.Value.ProductTypeId
                                        Price = y.Value.Price
                                        ImageUrl = x.ImageUrl
                                        // todo: verify this
                                        Quantity =
                                            cartItems
                                            |> List.filter (fun y -> y.ProductId = x.Id)
                                            |> List.sumBy (fun y -> y.Quantity)
                                    }
                                cartProductResponse)
                            
                        serviceResponse.Data <- cartProducts
                        return serviceResponse
                    }
            match resultQ with
            | Ok serviceResponse ->
                task
                    {
                        return serviceResponse
                    }
            | Error error ->
                let serviceResponse = ServiceResponse<List<CartProductResponse>>()
                serviceResponse.Message <- error
                task
                    {   
                        return serviceResponse
                    }
            
        member this.AddToCart(cartItem: CartItem) =
            let cartItem =
                {
                    cartItem with
                        UserId = authService.GetUserId()
                }
            let doUpdate =
                result {
                    let! cartItems = StateView.getAllAggregateStates<CartItem, CartItemEvents, string> eventStore
                    let cartItems = cartItems |>> snd
                    let cartItemFound =
                        cartItems
                        |> List.tryFind (fun ci -> ci.ProductId = cartItem.ProductId && ci.ProductTypeId = cartItem.ProductTypeId && ci.UserId = cartItem.UserId)
                        
                    match cartItemFound with
                    | Some existingCartItem ->
                        let updatedCartItem =
                            {
                              existingCartItem
                                with Quantity = existingCartItem.Quantity + cartItem.Quantity
                            }
                        let command =
                            CartItemCommands.UpdateCartItem updatedCartItem
                        let! commandExe =
                            runAggregateCommand<CartItem, CartItemEvents, string> cartItem.Id eventStore MessageSenders.NoSender command
                        return commandExe
                    | None ->
                        let! initialized =
                            runInit<CartItem, CartItemEvents, string> eventStore MessageSenders.NoSender cartItem
                        return initialized     
                }
            match doUpdate with
            | Ok _ ->
                let serviceResponse = ServiceResponse<bool>()
                serviceResponse.Data <- true
                task
                    {
                        return serviceResponse
                    }   
            | Error error ->
                let serviceResponse = ServiceResponse<bool>()
                serviceResponse.Message <- error
                serviceResponse.Data <- false
                task
                    {
                        return serviceResponse
                    }
                
        member this.GetCartItemsCount() =
            let userId = authService.GetUserId()
            let result =
                result {
                    let! cartItems =
                        StateView.getAllAggregateStates<CartItem, CartItemEvents, string> eventStore
                    let cartItems = cartItems |>> snd
                    let cartItemsCount =
                        cartItems
                        |> List.filter (fun x -> x.UserId = userId)
                        |> List.length
                    return cartItemsCount
                }
            match result with
            | Ok cartItemsCount ->
                let serviceResponse = ServiceResponse<int>()
                serviceResponse.Data <- cartItemsCount
                task
                    {
                        return serviceResponse
                    }
            | Error error ->
                let serviceResponse = ServiceResponse<int>()
                serviceResponse.Message <- error
                task
                    {
                        return serviceResponse
                    }
             
        member this.GetDbCartProducts(optUserId) =
            let userId =
                match optUserId with
                | Some userId -> userId
                | None -> authService.GetUserId()
            
            let result =
                result
                    {
                        let! cartItems =
                            getAllAggregateStates<CartItem, CartItemEvents, string> eventStore
                        let cartProducts = cartItems |>> snd
                        let filteredCartProducts = cartProducts |> List.filter (fun x -> x.UserId = userId)
                        return filteredCartProducts
                    }
            match result with
            | Ok cartItems ->
                cartItems
                (this :> ICartService).GetCartProducts cartItems
            | Error error ->
                let serviceResponse = ServiceResponse<List<CartProductResponse>>()
                serviceResponse.Message <- error
                task
                    {
                        return serviceResponse
                    }
                    
            
        member this.RemoveItemFromCart(productId, productTypeId) =
            let resultQ =
                result
                    {
                        let! cartItems =
                            getAllAggregateStates<CartItem, CartItemEvents, string> eventStore
                        let cartItems = cartItems |>> snd
                        let! cartItemFound =
                            cartItems
                            |> List.filter (fun x -> x.ProductId = productId && x.ProductTypeId = productTypeId)
                            |> List.tryHead
                            |> Result.ofOption "Cart item not found."
                        let! deleteCommand =    
                            runDelete<CartItem, CartItemEvents, string> eventStore MessageSenders.NoSender cartItemFound.Id (fun _ -> true)
                        return deleteCommand
                          
                    }
            match resultQ with
            | Ok deleted ->
                let serviceResponse = ServiceResponse<bool>()
                serviceResponse.Data <- true
                task
                    {
                        return serviceResponse
                    }
            | Error error ->
                let serviceResponse = ServiceResponse<bool>()
                serviceResponse.Message <- error
                serviceResponse.Data <- false
                task
                    {
                        return serviceResponse
                    }
        member this.StoreCartItems(cartItems) =
            let userId = authService.GetUserId()
            let cartItemsOfUser = cartItems |> List.filter (fun x -> x.UserId = authService.GetUserId())
            let updateExistingCreateNewOnes =
                result {
                    let existingCartItemsIds =
                        cartItems
                        |> List.map (fun (cartItem: CartItem) -> getAggregateFreshState<CartItem, CartItemEvents, string> cartItem.Id eventStore)
                        |> List.filter (fun x -> x.IsOk)
                        |> List.map (fun x -> x.OkValue)
                        |>> snd
                        |> List.map (fun x -> x :?> CartItem)
                        |> List.map (fun x -> x.Id)
                  
                    let idsWithUpdatedVersionCommands =
                        existingCartItemsIds
                        |> List.map (fun x -> (x,cartItems |> List.tryFind (fun y -> y.Id = x)))
                        |> List.filter (fun (x, y) -> y.IsSome)
                        |> List.map (fun (x, y) ->(x, CartItemCommands.UpdateCartItem y.Value))
                        
                    let! updateCarts =
                        idsWithUpdatedVersionCommands
                        |> List.traverseResultM (fun (x, y) -> runAggregateCommand<CartItem, CartItemEvents, string> x eventStore MessageSenders.NoSender y )
                    
                    let newCartItemIds =
                        cartItems
                        |> List.map (fun (cartItem: CartItem) -> (cartItem.Id, getAggregateFreshState<CartItem, CartItemEvents, string> cartItem.Id eventStore))
                        |> List.filter (fun (x, y) -> y.IsError)
                        |> List.map (fun (x, _) -> x)
                        
                    let idsWithNewItemsToBeCreated =
                        newCartItemIds
                        |> List.map (fun x -> (x, cartItems |> List.tryFind (fun y -> y.Id = x)))
                        |> List.filter (fun (x, y) -> y.IsSome)
                        |> List.map (fun (x, y) -> (x, y.Value))
                    
                    let! createNewOnes =
                        idsWithNewItemsToBeCreated
                        |> List.traverseResultM (fun (x, y) -> runInit<CartItem, CartItemEvents, string> eventStore MessageSenders.NoSender y)
                       
                    return () 
                }
            match updateExistingCreateNewOnes with
            | Ok () ->
                (this :> ICartService).GetDbCartProducts (userId |> Some)
            | Error _     ->
                let serviceResponse = ServiceResponse<List<CartProductResponse>>()
                serviceResponse.Message <- "Error updating cart items."
                task
                    {
                        return serviceResponse
                    }
                
        member this.UpdateQuantity(cartItem) =
            let doUpdate =
                result
                    {
                        let! cartItemFound =
                            getAggregateFreshState<CartItem, CartItemEvents, string> cartItem.Id eventStore
                        let cartItemFound = (cartItemFound |> snd :?> CartItem)   
                        let! updateCommand =
                            runAggregateCommand<CartItem, CartItemEvents, string> cartItemFound.Id eventStore  MessageSenders.NoSender (CartItemCommands.UpdateCartItem cartItem)
                        return updateCommand
                    }
            match doUpdate with
            | Error error ->
                let serviceResponse = ServiceResponse<bool>()
                serviceResponse.Message <- error
                serviceResponse.Data <- false
                serviceResponse.Success <- false
                task
                    {
                        return serviceResponse
                    }
            | Ok _ ->
                let serviceResponse = ServiceResponse<bool>()
                serviceResponse.Data <- true
                serviceResponse.Success <- true
                task
                    {
                        return serviceResponse
                    }
