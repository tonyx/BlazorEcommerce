namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type CartItem =
    {
        Id: Guid
        UserId: Guid
        ProductId: Guid
        ProductTypeId: Guid
        Quantity: int
    }
    
    with
        static member MkCartItem (userId: Guid, productId: Guid, productTypeId: Guid, ?quantity: int) =
            let quantity = defaultArg quantity 1
            {
                Id = Guid.NewGuid()
                UserId = userId
                ProductId = productId
                ProductTypeId = productTypeId
                Quantity = quantity
            }
       
        member this.Update (cartItem: CartItem) =
            cartItem |> Ok
            
        member this.Serialize =
            jsonPSerializer.Serialize this
        static member SnapshotsInterval = 1000
        static member StorageName = "_cartItem"
        static member Version = "_01"
        
        static member Deserialize x: Result<CartItem, string> =
            jsonPSerializer.Deserialize<CartItem> x
        
        interface Aggregate<string> with
            member this.Id = this.Id
            member this.Serialize = this.Serialize


