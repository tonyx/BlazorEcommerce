namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type ImageCommands =
    | UpdateImage of Image

with
    interface AggregateCommand<Image, ImageEvents> with
        member this.Execute(x) =
            match this with
                | UpdateImage image ->
                    x.Update image
                    |> Result.map (fun s -> (x, [Updated image])) 
                    
        member this.Undoer = None
