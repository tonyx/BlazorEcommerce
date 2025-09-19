namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.SharedFs.Models

module CategoryCommands =
    type CategoryCommands =
        | UpdateCategory of Category
    
    with
        interface AggregateCommand<Category, CategoryEvents> with
            member this.Execute(x) =
                match this with
                    | UpdateCategory category ->
                        x.Update category
                        |> Result.map (fun s -> (x, [Updated category])) 
                        
            member this.Undoer = None
