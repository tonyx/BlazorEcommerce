namespace BlazorEcommerc.ServerFs.Services

open System.Threading.Tasks
open BlazorEcommerce.SharedFs.Models
open BlazorEcommerce.ServerFs.Services
open BlazorEcommerce.SharedFs.Aliases
open BlazorEcommerce.SharedFs
open FSharpPlus.Operators
open FsToolkit.ErrorHandling
open Sharpino
open Sharpino.CommandHandler
open Sharpino.EventBroker
open Sharpino.Storage

type CategoryService(eventStore: IEventStore<string>) =
    interface ICategoryService with
        member this.GetCategories() =
            let categoriesGot =
                result
                    {
                        let! categories =
                            StateView.getAllAggregateStates<Category, CategoryEvents, string> eventStore
                        let result = categories |>> snd
                        return result
                    }
            match categoriesGot with
            | Ok categories ->
                let serviceResponse = ServiceResponse<List<Category>>()
                serviceResponse.Data <- categories
                task
                    {
                        return serviceResponse
                    }
            | Error error ->
                let serviceResponse = ServiceResponse<List<Category>>()
                serviceResponse.Message <- error
                task
                    {
                        return serviceResponse
                    }
            
        member this.AddCategory category =
            let addCategoryAndReturnCategories =
                result
                    {
                        let! createNewCategory =
                            runInit<Category, CategoryEvents, string> eventStore MessageSenders.NoSender category
                        return ()    
                    }
            match addCategoryAndReturnCategories with
            | Ok () ->
                (this:> ICategoryService).GetCategories ()
            | Error error ->
                task
                    {
                        let serviceResponse = ServiceResponse<List<Category>>()
                        serviceResponse.Message <- error
                        return serviceResponse
                    }
                    
        member this.DeleteCategory (categoryId) =
            let deleted =
                result {
                    let! result =
                        runDelete<Category, CategoryEvents, string> eventStore MessageSenders.NoSender categoryId (fun _ -> true)
                    return ()     
                }
            match deleted with
            | Ok () ->
                (this:> ICategoryService).GetCategories ()
            | Error error ->
                task
                    {
                        let response = ServiceResponse<List<Category>>()
                        response.Message <- error
                        return response
                    }
            
        member this.GetAdminCategories() =
            (this:> ICategoryService).GetCategories ()
            
        member this.UpdateCategory (category: Category) =
            let updated =
                result
                    {
                        let! category = 
                            StateView.getAggregateFreshState<Category, CategoryEvents, string> category.Id eventStore
                        let category = (category |> snd) :?> Category
                        let updatCategoryCommand = CategoryCommands.UpdateCategory category
                        let! result = runAggregateCommand<Category, CategoryEvents, string> category.Id eventStore MessageSenders.NoSender updatCategoryCommand
                        return ()
                    }
            match updated with
            | Ok () ->
                (this:> ICategoryService).GetCategories ()
            | Error error ->
                let serviceResponse = ServiceResponse<List<Category>>()
                serviceResponse.Message <- error
                task
                    {   
                        return serviceResponse
                    }
            
