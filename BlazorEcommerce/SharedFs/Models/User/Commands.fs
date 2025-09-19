namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

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
