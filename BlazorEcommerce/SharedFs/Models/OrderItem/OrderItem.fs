namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type OrderItem =
    {
        Id: Guid
        OrderId: Guid
        ProductId: Guid
        ProductTypeId: Guid
        Quantity: int
        TotalPrice: decimal
    }
    with
        static member
            MkOrderItem (orderId: Guid, productId: Guid, productTypeId: Guid, quantity: int, totalPrice: decimal) =
                {
                    Id = Guid.NewGuid()
                    OrderId = orderId
                    ProductId = productId
                    ProductTypeId = productTypeId
                    Quantity = quantity
                    TotalPrice = totalPrice
                }
                
        member this.Update (orderItem: OrderItem) =
            orderItem |> Ok
        member this.Serialize = jsonPSerializer.Serialize this
        static member SnapshotsInterval = 1000
        static member StorageName = "_orderItem"
        static member Version = "_01"
        
        static member Deserialize x: Result<OrderItem, string> =
            jsonPSerializer.Deserialize<OrderItem> x
        
        interface Aggregate<string> with
            member this.Id = this.Id
            member this.Serialize = this.Serialize
        
        
type OrderItemDetails =
    {
        OrderItem: OrderItem
        Product: Product
        ProductType: ProductType
    }
        
    