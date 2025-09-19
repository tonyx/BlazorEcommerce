namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type Order =
    {
        Id: Guid
        UserId: Guid
        OrderDate: DateTime
        TotalPrice: decimal
        OrderItemIds: List<Guid>
    }
    
    with
        static member MkOrder (userId: Guid, totalPrice: decimal, orderItemIds: List<Guid>, ?orderDate: DateTime) =
            let orderDate = defaultArg orderDate System.DateTime.Now
            {
                Id = Guid.NewGuid()
                UserId = userId
                OrderDate = orderDate
                TotalPrice = totalPrice
                OrderItemIds = orderItemIds
            }
            
        member this.Update (order: Order) =
            order |> Ok
        member this.Serialize = jsonPSerializer.Serialize this
        static member SnapshotsInterval = 1000
        static member StorageName = "_order"
        static member Version = "_01"
        
        static member Deserialize x: Result<Order, string> =
            jsonPSerializer.Deserialize<Order> x
        
        interface Aggregate<string> with
            member this.Id = this.Id
            member this.Serialize = this.Serialize

type OrderDetails =
    {
        Order: Order
        OrderItemDetails: List<OrderItemDetails>
    }