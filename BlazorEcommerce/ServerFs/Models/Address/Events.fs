namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models.Address

module AddressEvents =
    type AddressEvents =
        | Updated of Address
    
    with
        interface Event<Address> with
            member this.Process (state: Address) =
                match this with
                    | Updated address ->
                        state.Update address
                        
        member this.Serialize =
            jsonPSerializer.Serialize this
        static member Deserialize x: Result<AddressEvents, string> =
            jsonPSerializer.Deserialize<AddressEvents> x
            
