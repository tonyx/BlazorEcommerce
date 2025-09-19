namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type ProductType =
    {
        Id: Guid
        Name: string
        Editing: bool
        IsNew: bool
    }
    with
        static member MkProductType (name: string) =
            {
                Id = Guid.NewGuid()
                Name = name
                Editing = false
                IsNew = false
            }
            
        member this.Update (productType: ProductType) =
            productType |> Ok
        static member SnapshotsInterval = 1000
        static member StorageName = "_productType"
        static member Version = "_01"
       
        member this.Serialize = jsonPSerializer.Serialize this 
        static member Deserialize x: Result<ProductType, string> =
            jsonPSerializer.Deserialize<ProductType> x
        
        interface Aggregate<string> with
            member this.Id = this.Id
            member this.Serialize = this.Serialize
            