namespace BlazorEcommerce.ServerFs.Models


open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

module Image =
    type Image =
        {
           Id: Guid
           Data: string
        }
        with
            static member MkImage (data: string) =
                {
                    Id = Guid.NewGuid()
                    Data = data
                }
                
            member this.Update (image: Image) =
                image |> Ok
            member this.Serialize =
                jsonPSerializer.Serialize this
            static member SnapshotsInterval = 1000
            static member StorageName = "_image"
            static member Version = "_01"
            
            static member Deserialize x: Result<Image, string> =
                jsonPSerializer.Deserialize<Image> x
            
            interface Aggregate<string> with
                member this.Id = this.Id
                member this.Serialize = this.Serialize
                
        
