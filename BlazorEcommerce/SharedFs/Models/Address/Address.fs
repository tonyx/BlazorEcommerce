namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type Address =
    {
        Id: Guid
        UserId: Guid
        FirstName: string
        LastName: string
        Street: string
        City: string
        State: string
        Zip: string
        Country: string
    }
    with
        static member MkAddress (userId: Guid, firstName: string, lastName: string, street: string, city: string, state: string, zip: string, country: string) =
            {
                Id = Guid.NewGuid()
                UserId = userId
                FirstName = firstName
                LastName = lastName
                Street = street
                City = city
                State = state
                Zip = zip
                Country = country
            }
        member this.Update (address: Address) =
            address |> Ok
        member this.Serialize =
            jsonPSerializer.Serialize this
        static member SnapshotsInterval = 1000
        static member StorageName = "_address"
        static member Version = "_01"
        
        static member Deserialize x: Result<Address, string> =
            jsonPSerializer.Deserialize<Address> x
        
        interface Aggregate<string> with
            member this.Id = this.Id
            member this.Serialize = this.Serialize
            
            
        
   
