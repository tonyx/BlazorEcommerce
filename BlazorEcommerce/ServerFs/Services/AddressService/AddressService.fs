namespace BlazorEcommerce.ServerFs.Services.AddressService

open System
open System.IdentityModel.Tokens.Jwt
open System.Linq
open System.Security.Claims
open System.Security.Cryptography
open System.Threading.Tasks

open BlazorEcommerce.SharedFs.Models
open BlazorEcommerce.ServerFs.Services


open BlazorEcommerce.SharedFs
open Microsoft.AspNetCore.Http
open Microsoft.Extensions.Configuration
open Microsoft.IdentityModel.Tokens
open Sharpino
open Sharpino.CommandHandler
open Sharpino.EventBroker
open Sharpino.PgStorage
open Sharpino.StateView
open Sharpino.Storage
open FSharpPlus.Operators
open FsToolkit.ErrorHandling

type AddressService(eventStore: IEventStore<string>, authService: IAuthService) =
    new (configuration: IConfiguration, authService: IAuthService) =
        let connectionString = configuration.GetConnectionString("DefaultConnection")
        let eventStore = PgEventStore connectionString
        AddressService (eventStore, authService)
        
    interface IAddressService with
        member this.AddOrUpdateAddress(address) =
            taskResult
                {
                    let response = ServiceResponse<unit>()
                    let addressFound =
                        (this :> IAddressService).GetAddress()
                        |> Async.AwaitTask
                        |> Async.RunSynchronously
                    match addressFound with
                    | Error _ ->
                        let newAddress =
                            {
                                address with
                                    UserId = authService.GetUserId()
                             }
                        let! createAddress =
                            runInit<Address, AddressEvents, string> eventStore MessageSenders.NoSender newAddress
                        response.Data <- ()
                        return response    
                    | Ok addressFound ->
                        let! updatedAddress =
                            runAggregateCommand<Address, AddressEvents, string> address.Id eventStore MessageSenders.NoSender (AddressCommands.UpdateAddress address)
                        response.Data <- ()
                        return response
                }
            
        member this.GetAddress() =
            let userId = authService.GetUserId()
            taskResult
                {
                    let! adresses =
                        (StateView.getAllAggregateStates<Address, AddressEvents, string> eventStore)
                    
                    let adresses = adresses |>> snd
                    let! address =
                        adresses |> List.tryFind (fun x -> x.UserId = userId) |> Result.ofOption "Address not found."
                    let result =
                        ServiceResponse<Address>()
                    result.Data <- address
                    return result
                }
    
            
        