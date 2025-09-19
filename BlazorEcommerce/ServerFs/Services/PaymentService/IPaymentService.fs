namespace BlazorEcommerce.ServerFs.Services

open System
open System.Threading.Tasks
open BlazorEcommerce.SharedFs
open BlazorEcommerce.SharedFs.Aliases
open Microsoft.AspNetCore.Http
open Stripe.Checkout

/// Interface for payment service
type IPaymentService =
    abstract member CreateCheckoutSession : unit -> Task<Session>
    abstract member FulfillOrder: HttpRequest -> Task<ServiceResponse<bool>>

