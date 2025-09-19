namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type OrderEvents =
    | Updated of Order

with
    interface Event<Order> with
        member this.Process (state: Order) =
            match this with
                | Updated order ->
                    state.Update order
                    
    member this.Serialize =
        jsonPSerializer.Serialize this
    static member Deserialize x: Result<OrderEvents, string> =
        jsonPSerializer.Deserialize<OrderEvents> x
