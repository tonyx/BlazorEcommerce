namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models.Product

module ProductEvents =
    type ProductEvents =
        | Updated of Product
    
    with
        interface Event<Product> with
            member this.Process (state: Product) =
                match this with
                    | Updated product ->
                        state.Update product
                        
        member this.Serialize =
            jsonPSerializer.Serialize this
        static member Deserialize x: Result<ProductEvents, string> =
            jsonPSerializer.Deserialize<ProductEvents> x
