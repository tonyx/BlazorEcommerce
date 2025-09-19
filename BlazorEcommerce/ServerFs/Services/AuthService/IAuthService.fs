namespace BlazorEcommerce.ServerFs.Services

open System
open System.Threading.Tasks
open BlazorEcommerce.SharedFs.Models
open BlazorEcommerce.SharedFs

/// F# interface equivalent to the C# IAuthService
type IAuthService =
    /// Registers a new user with the given password
    abstract member Register: user: User * password: string -> Task<ServiceResponse<unit>>
    
    /// Checks if a user with the given email already exists
    abstract member UserExists: email: string -> Task<bool>
    
    /// Attempts to log in a user with the provided credentials
    abstract member Login: email: string * password: string -> Task<ServiceResponse<string>>
    
    /// Changes the password for the specified user
    abstract member ChangePassword: userId: Guid * newPassword: string -> Task<ServiceResponse<bool>>
    
    /// Gets the ID of the currently authenticated user
    abstract member GetUserId: unit -> Guid
    
    /// Gets the email of the currently authenticated user
    abstract member GetUserEmail: unit -> string
    
    /// Retrieves a user by their email address
    abstract member GetUserByEmail: email: string -> Task<Option<User>>
