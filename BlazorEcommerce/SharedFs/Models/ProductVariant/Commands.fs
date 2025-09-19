namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type ProductVariantCommands =
    | UpdateVariant of ProductVariant

with
    interface AggregateCommand<ProductVariant, ProductVariantEvents> with
        member this.Execute(x) =
            match this with
                | UpdateVariant variant ->
                    x.Update variant
                    |> Result.map (fun s -> (x, [Updated variant])) 
                    
        member this.Undoer = None
