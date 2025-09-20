# Blazor Ecommerce (F#) 

## Goal
An ongoing experiment related to refactoring the BlazorEcommerce (Udemy on line class) sample project to use F# and Sharpino on the backend in a Crud way.
which means:
- entities becomes event sourced objects (or "lightweight aggregates")
- each entity has only one transformation event: Update
- creation is based on runInit
- deletion is based on runDelete
- search: at this stage searching operations are not efficient (will be improved later)

### Current status 
I am writing a "shadow" replication of Shared and Server project in F# by adding some hacks like mixing idiomatic F# and C# at the same time.
They should be able, sooner or later, to replace the original C# projects.

### Projects

- **Shared**: Shared code between client and server
- **SharedFs**: Shared code between client and server (F#)
- **Server**: Server side code
- **ServerFs**: Server side code (F#)
- **Client**: Client side code

### Technologies

- **.NET 9**: .NET 9 is the latest version of .NET, a free, open-source, cross-platform framework for building many different types of applications.
- **F#**: F# is a functional programming language for .NET. For ServerFs project.
- **Blazor**: Blazor is a framework for building web applications using .NET.
- **Entity Framework Core**: Entity Framework Core is a modern object-database mapper for .NET.
- **Stripe**: Stripe is a payment processing service.