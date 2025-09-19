namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type CategoryEvents =
    | Updated of Category

with
    interface Event<Category> with
        member this.Process (state: Category) =
            match this with
                | Updated category ->
                    state.Update category
                    
    member this.Serialize =
        jsonPSerializer.Serialize this
    static member Deserialize x: Result<CategoryEvents, string> =
        jsonPSerializer.Deserialize<CategoryEvents> x
