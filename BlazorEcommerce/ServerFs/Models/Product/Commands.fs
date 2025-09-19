namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models.Product
open BlazorEcommerce.ServerFs.Models.ProductEvents

module ProductCommands =
    type ProductCommands =
        | UpdateProduct of Product
    
    with
        interface AggregateCommand<Product, ProductEvents> with
            member this.Execute(x) =
                match this with
                    | UpdateProduct product ->
                        x.Update product
                        |> Result.map (fun s -> (x, [Updated product])) 
                        
            member this.Undoer = None
