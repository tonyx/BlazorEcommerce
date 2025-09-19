namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models.ProductType
open BlazorEcommerce.ServerFs.Models.ProductTypeEvents

module ProductTypeCommands =
    type ProductTypeCommands =
        | UpdateProductType of ProductType
    
    with
        interface AggregateCommand<ProductType, ProductTypeEvents> with
            member this.Execute(x) =
                match this with
                    | UpdateProductType productType ->
                        x.Update productType
                        |> Result.map (fun s -> (x, [Updated productType])) 
                        
            member this.Undoer = None
