namespace BlazorEcommerce.ServerFs.Services

open System.Threading.Tasks
open BlazorEcommerce.SharedFs.Models
open BlazorEcommerce.SharedFs

open Sharpino
open Sharpino.CommandHandler
open Sharpino.Definitions
open System
open FSharpPlus.Operators
open FsToolkit.ErrorHandling
open Sharpino.Storage
open Sharpino.Core
open Sharpino.Utils

/// F# interface equivalent to the C# IAddressService
type IAddressService =
    /// Gets the address for the current user
    abstract member GetAddress: unit -> TaskResult<ServiceResponse<Address>, string>
    
    /// Adds or updates the address for the current user
    abstract member AddOrUpdateAddress: address: Address -> TaskResult<ServiceResponse<unit>, string>
