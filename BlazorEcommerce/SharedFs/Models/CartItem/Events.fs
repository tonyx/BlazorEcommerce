namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.SharedFs.Models

    type CartItemEvents =
        | Updated of CartItem
    
    with
        interface Event<CartItem> with
            member this.Process (state: CartItem) =
                match this with
                    | Updated cartItem ->
                        state.Update cartItem
                        
        member this.Serialize =
            jsonPSerializer.Serialize this
        static member Deserialize x: Result<CartItemEvents, string> =
            jsonPSerializer.Deserialize<CartItemEvents> x
