namespace BlazorEcommerce.ServerFs.Services

open System
open System.Threading.Tasks
open BlazorEcommerce.SharedFs
open BlazorEcommerce.SharedFs.Aliases
open Microsoft.AspNetCore.Http
open Stripe.Checkout

type PaymentService() =
    interface IPaymentService with
        member this.CreateCheckoutSession () = failwith "not implemented"
        member this.FulfillOrder (httpRequest) =  failwith "not implemented"  


