namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type OrderItemEvents =
    | Updated of OrderItem

with
    interface Event<OrderItem> with
        member this.Process (state: OrderItem) =
            match this with
                | Updated orderItem ->
                    state.Update orderItem
                    
    member this.Serialize =
        jsonPSerializer.Serialize this
    static member Deserialize x: Result<OrderItemEvents, string> =
        jsonPSerializer.Deserialize<OrderItemEvents> x
