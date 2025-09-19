namespace BlazorEcommerce.ServerFs.Services

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
open BlazorEcommerce.SharedFs.Aliases



type ICartService =
    abstract member GetCartProducts: List<CartItem> -> Task<ServiceResponse<List<CartProductResponse>>>
    abstract member StoreCartItems: List<CartItem> -> Task<ServiceResponse<List<CartProductResponse>>>
    abstract member GetCartItemsCount: unit -> Task<ServiceResponse<int>>
    abstract member GetDbCartProducts: Option<UserId> -> Task<ServiceResponse<List<CartProductResponse>>>
    abstract member AddToCart: CartItem -> Task<ServiceResponse<bool>>
    abstract member UpdateQuantity: CartItem -> Task<ServiceResponse<bool>>
    abstract member RemoveItemFromCart: ProductId * ProductTypeId -> Task<ServiceResponse<bool>>

