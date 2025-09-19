namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models.ProductType

module ProductTypeEvents =
    type ProductTypeEvents =
        | Updated of ProductType
    
    with
        interface Event<ProductType> with
            member this.Process (state: ProductType) =
                match this with
                    | Updated productType ->
                        state.Update productType
                        
        member this.Serialize =
            jsonPSerializer.Serialize this
        static member Deserialize x: Result<ProductTypeEvents, string> =
            jsonPSerializer.Deserialize<ProductTypeEvents> x
