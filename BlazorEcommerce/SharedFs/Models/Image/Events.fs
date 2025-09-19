namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type ImageEvents =
    | Updated of Image

with
    interface Event<Image> with
        member this.Process (state: Image) =
            match this with
                | Updated image ->
                    state.Update image
                    
    member this.Serialize =
        jsonPSerializer.Serialize this
    static member Deserialize x: Result<ImageEvents, string> =
        jsonPSerializer.Deserialize<ImageEvents> x
