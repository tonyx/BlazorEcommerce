namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models.Image
open BlazorEcommerce.ServerFs.Models.ImageEvents

module ImageCommands =
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
