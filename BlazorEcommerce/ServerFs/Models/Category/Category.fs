namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

module Category =
    type Category =
        {
            Id: Guid
            Name: string
            Url: string
            Visible: bool
            Delete: bool
            Editing: bool
            IsNew: bool
        }
        with
            static member
                MkCategory (name: string, url: string) =
                    {
                        Id = Guid.NewGuid()
                        Name = name
                        Url = url
                        Visible = true
                        Delete = false
                        Editing = false
                        IsNew = true
                    }
                    
            member this.Update (category: Category) =
                category |> Ok
            member this.Serialize =
                jsonPSerializer.Serialize this
            static member SnapshotsInterval = 1000
            static member StorageName = "_category"
            static member Version = "_01"
            
            static member Deserialize x: Result<Category, string> =
                jsonPSerializer.Deserialize<Category> x
            
            interface Aggregate<string> with
                member this.Id = this.Id
                member this.Serialize = this.Serialize
            