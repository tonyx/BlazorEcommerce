namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

module OrderCommands =
    type OrderCommands =
        | UpdateOrder of Order
    
    with
        interface AggregateCommand<Order, OrderEvents> with
            member this.Execute(x) =
                match this with
                    | UpdateOrder order ->
                        x.Update order
                        |> Result.map (fun s -> (x, [Updated order])) 
                        
            member this.Undoer = None
