namespace BlazorEcommerce.ServerFs.Services

open System
open BlazorEcommerce.SharedFs.Models
open BlazorEcommerce.SharedFs
open BlazorEcommerce.SharedFs.Aliases
open BlazorEcommmerce.SharedFs
open Sharpino
open Sharpino.CommandHandler
open Sharpino.EventBroker
open Sharpino.Storage
open BlazorEcommerce.ServerFs.Services

open FSharpPlus.Operators
open FsToolkit.ErrorHandling

type OrderService(eventStore: IEventStore<string>, cartService: ICartService, authService: IAuthService) =
    member this.GetOrderItemDetails orderId =
        result {
            let! orderItem = StateView.getAggregateFreshState<OrderItem, OrderItemEvents, string> orderId eventStore |> Result.map snd
            let orderItem = orderItem :?> OrderItem
            let! product = StateView.getAggregateFreshState<Product, ProductEvents, string> orderItem.ProductId eventStore |> Result.map snd
            let product = product :?> Product
            let! productType = StateView.getAggregateFreshState<ProductType, ProductTypeEvents, string> orderItem.ProductTypeId eventStore |> Result.map snd
            let productType = productType :?> ProductType
            let orderItemDetails =
                {
                    OrderItem = orderItem
                    Product = product
                    ProductType = productType
                }
            return orderItemDetails    
        }
    
    member this.GetOrderDetails orderId =
        result
            {
                let! order = StateView.getAggregateFreshState<Order, OrderEvents, string> orderId eventStore
                let order = (order |> snd) :?> Order
                let! orderItemDetails =
                    order.OrderItemIds
                    |> List.traverseResultM (fun orderId -> this.GetOrderItemDetails orderId)
                return
                    {
                        Order = order
                        OrderItemDetails = orderItemDetails
                    }
            }
    
    interface IOrderService with
        member this.GetOrderDetails(orderId: OrderId) =
            let getOrder =
                result {
                    let! order = StateView.getAggregateFreshState<Order, OrderEvents, string> orderId eventStore
                    let order = (order |> snd) :?> Order
                    
                    let! orderItemDetails =
                        order.OrderItemIds
                        |> List.traverseResultM (fun orderId -> this.GetOrderItemDetails orderId)
                    
                    
                    let orderDetailProductResponses =
                        orderItemDetails
                        |> List.map (fun item ->
                            let orderDetailsProductResponse: OrderDetailsProductResponse =
                                {
                                    ProductId = item.Product.Id
                                    Title = item.Product.Title
                                    ProductType = item.ProductType.Name
                                    ImageUrl = item.Product.ImageUrl
                                    Quantity = item.OrderItem.Quantity
                                    TotalPrice = item.OrderItem.TotalPrice
                                }
                            orderDetailsProductResponse
                            )
                         
                    
                    let orderDetailsResponse: OrderDetailsResponse =
                        {
                            OrderDate = order.OrderDate
                            TotalPrice = order.TotalPrice
                            Products = orderDetailProductResponses 
                        }
                    return orderDetailsResponse
                    
                    // let response = ServiceResponse<OrderDetailsResponse> ()
                    // response.Data <- orderDetailsResponse
                    // response.Success <- true
                    // response.Message <- "Order details retrieved successfully."
                    // return response
                }
            match getOrder with
            | Ok orderResponse ->
                let response = ServiceResponse<OrderDetailsResponse>()
                response.Data <- orderResponse
                response.Success <- true
                response.Message <- "Order details retrieved successfully."
                task
                    {
                        return response
                    }
            | Error error ->
                let response = ServiceResponse<OrderDetailsResponse>()
                response.Success <- false
                response.Message <- error
                task
                    {
                        return response
                    }
                
        member this.GetOrders ()=
            let userId = authService.GetUserId()
            let ordersGot =
                result
                    {
                        let! orders =
                            (StateView.getAllAggregateStates<Order, OrderEvents, string> eventStore)
                        let orders = orders |>> snd
                        let filteredOrders =
                            orders
                            |> List.filter (fun x -> x.UserId = userId)
                        
                        let filteredOrderIds =
                            filteredOrders
                            |> List.map (fun x -> x.Id)
                        
                        let! orderDetails =
                            filteredOrderIds
                            |> List.traverseResultM (fun x -> this.GetOrderDetails x)
                            
                        let orderOverviews =
                            orderDetails
                            |> List.map
                                (fun x ->
                                    {
                                        Id = x.Order.Id
                                        OrderDate = x.Order.OrderDate
                                        TotalPrice = x.Order.TotalPrice
                                        Product =
                                            if (x.OrderItemDetails.Length > 0) then
                                                x.OrderItemDetails.Head.Product.Title
                                            else
                                                ""
                                        ProductImageUrl =
                                            if (x.OrderItemDetails.Length > 0) then
                                                x.OrderItemDetails.Head.Product.ImageUrl
                                            else
                                                ""
                                    }
                               )
                        return orderOverviews
                    }
            match ordersGot with
            | Ok orderOverviews ->
                let response = ServiceResponse<List<OrderOverviewResponse>>()
                response.Data <- orderOverviews
                response.Success <- true
                response.Message <- "Orders retrieved successfully."
                task
                    {
                        return response
                    }
            | Error error ->
                let response = ServiceResponse<List<OrderOverviewResponse>>()
                response.Success <- false
                response.Message <- error
                task
                    {
                        return response
                    }
            
        member this.PlaceOrder(userId) =
            let placed =
                result
                    {
                        let products =
                            cartService.GetDbCartProducts (userId |> Some)
                            |> Async.AwaitTask
                            |> Async.RunSynchronously
                            |> (fun x -> x.Data)
                            
                        let totalPrice =
                            products
                            |> List.map (fun x -> (x.Price * (decimal)x.Quantity))
                            |> List.sum
                        
                        let orderId = Guid.NewGuid()
                        let orderItems: List<OrderItem> =
                            products
                            |> List.map (fun x ->
                                {
                                    Id = Guid.NewGuid()
                                    OrderId = orderId
                                    ProductId = x.ProductId
                                    ProductTypeId = x.ProductTypeId
                                    Quantity = x.Quantity
                                    TotalPrice = x.Price * (decimal)x.Quantity
                                }
                            )
                            
                        let order: Order =
                            {
                                Id = orderId
                                UserId = userId
                                OrderDate = DateTime.Now
                                TotalPrice = totalPrice
                                OrderItemIds = orderItems |> List.map (fun x -> x.Id)
                            }
                        let! saveOrderItems =
                            orderItems
                            |> List.traverseResultM (fun x -> runInit<OrderItem, OrderItemEvents, string> eventStore MessageSenders.NoSender x)
                        let! saveOrder =
                            runInit<Order, OrderEvents, string> eventStore MessageSenders.NoSender order
                       
                        let! cartItems =
                            StateView.getAllAggregateStates<CartItem, CartItemEvents, string> eventStore
                        let cartItems = cartItems |>> snd
                        let cartItemsOfUser = cartItems |> List.filter (fun x -> x.UserId = userId)
                        let cartItemsIds = cartItemsOfUser |> List.map (fun x -> x.Id)
                        let! deleteCartItems =
                            cartItemsIds
                            |> List.traverseResultM (fun x -> runDelete<CartItem, CartItemEvents, string> eventStore MessageSenders.NoSender x  (fun _ -> true))
                            
                        return ()
                    }
            match placed with
            | Ok _ ->
                let response = ServiceResponse()
                response.Success <- true
                task {
                    return response
                }
            | Error _ ->
                let response = ServiceResponse()
                response.Success <- false
                task {
                    return response
                }
    
    
    
