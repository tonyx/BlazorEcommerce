namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models
open BlazorEcommerce.ServerFs.Models

type OrderItemCommands =
    | UpdateOrderItem of OrderItem

with
    interface AggregateCommand<OrderItem, OrderItemEvents> with
        member this.Execute(x) =
            match this with
                | UpdateOrderItem orderItem ->
                    x.Update orderItem
                    |> Result.map (fun s -> (x, [Updated orderItem])) 
                    
        member this.Undoer = None
