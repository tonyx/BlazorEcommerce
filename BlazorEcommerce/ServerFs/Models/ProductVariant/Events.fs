namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models.ProductVariant

module ProductVariantEvents =
    type ProductVariantEvents =
        | Updated of ProductVariant
    
    with
        interface Event<ProductVariant> with
            member this.Process (state: ProductVariant) =
                match this with
                    | Updated variant ->
                        state.Update variant
                        
        member this.Serialize =
            jsonPSerializer.Serialize this
        static member Deserialize x: Result<ProductVariantEvents, string> =
            jsonPSerializer.Deserialize<ProductVariantEvents> x
