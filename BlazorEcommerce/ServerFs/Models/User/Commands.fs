namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core
open BlazorEcommerce.ServerFs.Models.User
open BlazorEcommerce.ServerFs.Models.UserEvents

module UserCommands =
    type UserCommands =
        | UpdateUser of User
    
    with
        interface AggregateCommand<User, UserEvents> with
            member this.Execute(x) =
                match this with
                    | UpdateUser user ->
                        x.Update user
                        |> Result.map (fun s -> (x, [Updated user])) 
                        
            member this.Undoer = None
