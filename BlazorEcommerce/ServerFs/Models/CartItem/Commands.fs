namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models

module CartItemCommands =
    type CartItemCommands =
        | UpdateCartItem of CartItem
    
    with
        interface AggregateCommand<CartItem, CartItemEvents> with
            member this.Execute(x) =
                match this with
                    | UpdateCartItem cartItem ->
                        x.Update cartItem
                        |> Result.map (fun s -> (x, [Updated cartItem])) 
                        
            member this.Undoer = None
