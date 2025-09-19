namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

module User =
    type User =
        {
            Id: Guid
            Email: string
            PasswordHash: byte[]
            PasswordSalt: byte[]
            DateCreated: DateTime
            Role: string
        }
        with
            static member MkUser (email: string, passwordHash: byte[], passwordSalt: byte[], dateCreated: DateTime, ?role: string) =
                {
                    Id = Guid.NewGuid()
                    Email = email
                    PasswordHash = passwordHash
                    PasswordSalt = passwordSalt
                    DateCreated = dateCreated
                    Role = defaultArg role "User"
                }
                
            member this.Update (user: User) =
                user |> Ok
            member this.Serialize = jsonPSerializer.Serialize this
            static member SnapshotsInterval = 1000
            static member StorageName = "_user"
            static member Version = "_01"
            
            static member Deserialize x: Result<User, string> =
                jsonPSerializer.Deserialize<User> x
            
            interface Aggregate<string> with
                member this.Id = this.Id
                member this.Serialize = this.Serialize
            
            
