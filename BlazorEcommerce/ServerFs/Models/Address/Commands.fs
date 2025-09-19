namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models.Address
open BlazorEcommerce.ServerFs.Models.AddressEvents

module AddressCommands =
    type AddressCommands =
        | UpdateAddress of Address
    
    with
        interface AggregateCommand<Address, AddressEvents> with
            member this.Execute(x) =
                match this with
                    | UpdateAddress address ->
                        x.Update address
                        |> Result.map (fun s -> (x, [Updated address])) 
                        
            member this.Undoer = None
            
    