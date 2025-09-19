namespace BlazorEcommerce.ServerFs.Services
open System.Threading.Tasks
open BlazorEcommerce.SharedFs
open BlazorEcommerce.SharedFs.Models
open BlazorEcommerce.SharedFs.Aliases
open Microsoft.AspNetCore.Http
open Sharpino
open Sharpino.CommandHandler
open Sharpino.EventBroker
open Sharpino.StateView
open Sharpino.Storage
open FSharpPlus.Operators
open FsToolkit.ErrorHandling

type ProductService(eventStore: IEventStore<string>, httpContextAccessor: IHttpContextAccessor) =
    member this.GetProductDetails (productId) =
        result
            {
                let! product = getAggregateFreshState<Product, ProductEvents, string> productId eventStore
                let product = product |> snd :?> Product
                let! category = getAggregateFreshState<Category, CategoryEvents, string> product.CategoryId eventStore
                let category = category |> snd :?> Category
                let result: ProductDetails =
                    {
                        Product = product
                        ProductCategory = category
                    }
                return result    
            }
    
    member this.GetAllProducsDetails () =
        result
            {
                let! productsGot = StateView.getAllAggregateStates<Product, ProductEvents, string> eventStore
                let productsGotIds = productsGot |> List.map snd |> List.map (fun x -> x.Id)
                let! productDetails =
                    productsGotIds
                    |> List.traverseResultM (fun x -> this.GetProductDetails x)
                return productDetails
            }    
            
    member this.FindProductsBySearchText (searchText: string) =
        result
            {
                let! productsGot = getAllAggregateStates<Product, ProductEvents, string> eventStore
                let productsGot = productsGot |> List.map snd
                let filteredProducts =
                    productsGot
                    |> List.filter
                           (fun product -> (product.Title.ToLower().Contains(searchText.ToLower()) || product.Description.ToLower().Contains(searchText.ToLower())))
                return filteredProducts
            }
    interface IProductService with
        member this.CreateProduct(product: Product) =
            let created =
                result
                    {
                        // todo: verify that doesn't already exist
                        let! created =
                            runInit<Product, ProductEvents, string> eventStore MessageSenders.NoSender product
                        return created    
                    }
            match created with
            | Ok created ->
                let serviceResponse = ServiceResponse<Product>()
                serviceResponse.Data <- product
                task
                    {
                        return serviceResponse
                    }
            | Error error ->
                let serviceResponse = ServiceResponse<Product>()
                serviceResponse.Message <- error
                task
                    {
                        return serviceResponse
                    }
        member this.DeleteProduct(productId) =
            let deleted =
                result
                    {
                        let delete = runDelete<Product, ProductEvents, string> eventStore MessageSenders.NoSender productId (fun _ -> true)
                        return ()
                    }
            match deleted with
            | Ok () ->
                let serviceResponse = ServiceResponse<bool>()
                serviceResponse.Data <- true
                task
                    {
                        return serviceResponse    
                    }
            | Error error ->
                let serviceResponse = ServiceResponse<bool>()
                serviceResponse.Message <- error
                task
                    {
                        return serviceResponse    
                    }
        member this.GetAdminProducts() =
            let adminProductsGot =
                result
                    {
                        let! productsGot = getAllAggregateStates<Product, ProductEvents, string> eventStore
                        let productsGot = productsGot |> List.map snd
                        return productsGot
                    }
            let productResponse = ServiceResponse<List<Product>>()
            match adminProductsGot with
            | Ok products ->
                productResponse.Data <- products
                task
                    {
                        return productResponse
                    }
            | Error error ->
                productResponse.Message <- error
                task
                    {
                        return productResponse
                    }
        member this.GetFeaturedProducts() =
            (this :> IProductService).GetAdminProducts()
        member this.GetProductAsync productId =
            // don't mind checking admin
            let productGot =
                result
                    {
                        let! productGot = getAggregateFreshState<Product, ProductEvents, string> productId eventStore
                        let productGot = (productGot |> snd) :?> Product
                        return productGot
                    }
            let response = ServiceResponse<Product>()
            match productGot with
            | Ok product ->
                response.Data <- product
                task
                    {
                        return response
                    }
            | Error error ->
                response.Message <- error
                task
                    {
                        return response
                    }
            
        member this.GetProductSearchSuggestions searchText =
            let suggestionsGot =
                result
                    {
                        let! suggestions = (this :> ProductService).FindProductsBySearchText(searchText)
                        return suggestions
                    }
            let serviceResponse = ServiceResponse<List<string>>()
            match suggestionsGot with
            | Ok suggestions ->
                let names = suggestions |> List.map (fun x -> x.Title)
                serviceResponse.Data <- names
                task
                    {
                        return serviceResponse
                    }
            | Error error ->
                serviceResponse.Message <- error
                task
                    {
                        return serviceResponse
                    }
                
        member this.GetProductsAsync() =
            let productsGot =
                result
                    {
                        let! products = getAllAggregateStates<Product, ProductEvents, string> eventStore
                        let products = products |> List.map snd
                        return products
                    }
            let response = ServiceResponse<List<Product>>()
            match productsGot with
            | Ok products ->
                response.Data <- products
                task
                    {
                        return response
                }
            | Error error ->
                response.Success <- false
                response.Message <- error
                task
                    {
                        return response
                    }    
            
        member this.GetProductsByCategory(categoryUrl) =
            let productsGot =
                result
                    {
                        let! productDetails = this.GetAllProducsDetails()
                        let filteredProductDetails = productDetails |> List.filter (fun x -> x.ProductCategory.Url.ToLower() = categoryUrl.ToLower())
                        let onlyProducts = filteredProductDetails |> List.map (fun x -> x.Product)
                        return onlyProducts
                    }
            let response = ServiceResponse<List<Product>>()
            match productsGot with
            | Ok products ->
                response.Data <- products
                task
                    {
                        return response
                    }
            | Error error ->
                response.Message <- error
                task
                    {
                        return response
                    }
            
        member this.SearchProducts(searchText, page) =
            let productsGot =
                result {
                    let pageResults = 2f
                    let! productsGot = this.FindProductsBySearchText searchText
                    let pageCount = ceil (float32 (List.length productsGot) / pageResults)
                    let products = productsGot |> List.skip (int ((page - 1) * (int)pageResults)) |> List.take (int pageResults)
                    let (productSearchResult: ProductSearchResult) =
                        {
                            Products = products
                            CurrentPage = page
                            Pages = (int)pageCount
                        }
                    return productSearchResult    
                }
            let response = ServiceResponse<ProductSearchResult>()     
            match productsGot with
            | Ok products ->
                response.Data <-
                    products
                task
                    {
                        return response
                    }
            | Error error ->
                response.Message <- error
                task {
                    return response
                }
            
        member this.UpdateProduct product =
            let updated =
                result
                    {
                        let! productGot = getAggregateFreshState<Product, ProductEvents, string> product.Id eventStore
                        let productGot = productGot |> snd :?> Product
                        let updateProduct = ProductCommands.UpdateProduct productGot
                        let! doUpdate =
                            runAggregateCommand<Product, ProductEvents, string> product.Id eventStore MessageSenders.NoSender updateProduct
                        return product    
                    }
            let serviceResponse = ServiceResponse<Product>()         
            match updated with
            | Ok product ->
                serviceResponse.Data <- product
                task
                    {
                        return serviceResponse
                    }
            | Error error ->
                serviceResponse.Message <- error
                task
                    {
                        return serviceResponse
                    }
    