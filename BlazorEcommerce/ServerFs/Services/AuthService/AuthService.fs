namespace BlazorEcommerce.ServerFs.Services

open System
open System.IdentityModel.Tokens.Jwt
open System.Linq
open System.Security.Claims
open System.Security.Cryptography
open System.Threading.Tasks
open BlazorEcommerce.SharedFs.Models
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


/// F# implementation of the IAuthService interface

type AuthService (eventStore: IEventStore<string>, configuration: IConfiguration, httpContextAccessor: HttpContextAccessor) =
    new (configuration: IConfiguration, httpContextAccessor: HttpContextAccessor) =
        let connectionString = configuration.GetConnectionString("DefaultConnection")
        let eventStore = PgEventStore connectionString
        AuthService (eventStore, configuration, httpContextAccessor)
        
    member private this.CreateToken(user: User) =
        let claims =
            List.ofSeq
                [
                    Claim(ClaimTypes.NameIdentifier, user.Id.ToString())
                    Claim(ClaimTypes.Name, user.Email)
                    Claim(ClaimTypes.Role, user.Role)
                ]
                
        let key =
            new SymmetricSecurityKey(Text.Encoding.UTF8.GetBytes("your-256-bit-secret"))
            
            Text.Encoding.UTF8.GetBytes("your-256-bit-secret")
        
        
        let tokenHandler = new JwtSecurityTokenHandler()
        let creds = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256)
        let token = new JwtSecurityToken(issuer = "your-issuer", audience = "your-audience", claims = [new Claim(ClaimTypes.NameIdentifier, user.Id.ToString())], expires = DateTime.Now.AddMinutes(30.0), signingCredentials = creds)
        tokenHandler.WriteToken(token)
        
        
    member private this.CreatePasswordHash(password: string, passwordHash: byref<byte[]>, passwordSalt: byref<byte[]>) =
        let hmac = HMACSHA512()
        let passwordSalt = hmac.Key
        let passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password))
        ()
    
    member private this.VerifyPasswordHash(password: string, passwordHash: byte[], passwordSalt: byte[]) =
        let hmac = HMACSHA512 passwordSalt
        let computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password))
        computedHash.SequenceEqual passwordHash
        
    interface IAuthService with
        member this.GetUserId() =
            httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier) |> Guid.Parse
        member this.GetUserEmail() = 
            httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.Name)
        member this.Login(email, password) =
            let result =
                result {
                   let! users =
                       StateView.getAllAggregateStates<User, UserEvents, string> eventStore
                   let users = users |>> snd
                   let! userFound =
                       (users |> List.tryFind (fun x -> x.Email = email) |> Result.ofOption "User not found.")
                   let! verifyPasswordHash =
                       this.VerifyPasswordHash(password, userFound.PasswordHash, userFound.PasswordSalt)
                       |> Result.ofBool "Invalid password."
                   return userFound
                }
            match result with
            | Ok userFound ->
                let response = ServiceResponse<string>()
                response.Data <- this.CreateToken(userFound)
                task
                    {
                      return response
                    }
            | Error error ->
                let response = ServiceResponse<string>()
                response.Success <- false
                response.Message <- error
                task
                    {
                        return response
                    }
            
        member this.UserExists(email) =
            let result =
                result
                    {
                        let! users =
                            StateView.getAllAggregateStates<User, UserEvents, string> eventStore
                        let users = users |>> snd
                        let! userFound =
                            (users |> List.tryFind (fun x -> x.Email = email) |> Result.ofOption "User not found.")
                        return ()    
                    }
            task
               {
                   match result with
                   | Ok _ -> return true
                   | Error _ -> return false
               }
        
        member this.GetUserByEmail(email) =
            let findUser =
                result {
                    let! users =
                        StateView.getAllAggregateStates<User, UserEvents, string> eventStore
                    let users = users |>> snd
                    let! userFound =
                        (users |> List.tryFind (fun x -> x.Email = email) |> Result.ofOption "User not found.")
                    return userFound
                }
            match findUser with
            | Ok userFound ->
                task
                    {
                        return (userFound |> Some)
                    }
            | Error _ ->
                task
                   {
                       return None
                   } 
                    
        member this.ChangePassword(userId, newPassword) =
            let changePassword =
                result {
                    let! user =
                        (StateView.getAggregateFreshState<User, UserEvents, string> userId eventStore
                         |> Result.map snd
                         |> Result.mapError (fun _ -> "User not found.")
                         )
                    let user' = user :?> User    
                    let mutable passwordHash = Array.zeroCreate<byte> 0
                    let mutable passwordSalt = Array.zeroCreate<byte> 0
                    let _ =
                        this.CreatePasswordHash(newPassword, &passwordHash, &passwordSalt)
                    let userChanged =
                        {
                            user' with
                                PasswordHash = passwordHash
                                PasswordSalt = passwordSalt
                        }
                    return userChanged    
                }
            let result =    
                match
                    changePassword with
                    | Ok userChanged ->
                        let result =
                            runAggregateCommand<User, UserEvents, string> userChanged.Id eventStore MessageSenders.NoSender (UserCommands.UpdateUser userChanged)
                        result
                    | Error error ->
                        Error error    
            match result with
            | Ok _ ->
                let response = ServiceResponse<bool>()
                response.Success <- true
                response.Message <- "Password has been changed."
                task
                    {
                        return response
                    }
            | Error error ->
                let response = ServiceResponse<bool>()
                response.Success <- false
                response.Message <- error
                task
                    {
                        return response
                    }    
                        
        member this.Register(user, password) =
            let findUser =
                result {
                    let! users =
                        StateView.getAllAggregateStates<User, UserEvents, string> eventStore
                    let users = users |>> snd
                    let! userFound =
                        (users |> List.tryFind (fun x -> x.Email = user.Email) |> Result.ofOption "User not found.")
                    return userFound
                }
            match findUser with
            | Ok userFound ->
                let response = ServiceResponse<Unit>()
                response.Success <- false
                response.Message <- "User already exists."
                task
                    {
                        return response
                    }
            | Error error ->
                let createUser =
                    runInit<User, UserEvents, string> eventStore MessageSenders.NoSender user
                match createUser with
                | Ok _ ->
                    let response = ServiceResponse<Unit>()
                    response.Success <- true
                    response.Message <- "User has been created."
                    task
                        {
                           return response 
                        }
                | Error error ->
                    let response = ServiceResponse<Unit>()
                    response.Success <- false
                    response.Message <- error
                    task
                        {
                            return response
                        }
                
                    