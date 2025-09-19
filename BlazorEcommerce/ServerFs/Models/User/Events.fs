namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models.User

module UserEvents =
    type UserEvents =
        | Updated of User
    
    with
        interface Event<User> with
            member this.Process (state: User) =
                match this with
                    | Updated user ->
                        state.Update user
                        
        member this.Serialize =
            jsonPSerializer.Serialize this
        static member Deserialize x: Result<UserEvents, string> =
            jsonPSerializer.Deserialize<UserEvents> x
