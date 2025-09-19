namespace BlazorEcommerce.ServerFs.Services

open System.Threading.Tasks
open BlazorEcommerce.SharedFs
open BlazorEcommerce.SharedFs.Aliases
open BlazorEcommerce.SharedFs.Models
open Sharpino
open Sharpino.CommandHandler
open Sharpino.EventBroker
open Sharpino.Storage
open FSharpPlus.Operators
open FsToolkit.ErrorHandling

type ProductTypeService (eventStore: IEventStore<string>) =
    interface IProductTypeService with
        member this.GetProductTypes () =
            let productsGot =
                result
                    {
                        let! productsGot = StateView.getAllAggregateStates<ProductType, ProductTypeEvents, string> eventStore
                        let productsGot = productsGot |>> snd
                        let productResponse = ServiceResponse<List<ProductType>>()
                        productResponse.Data <- productsGot
                        return productResponse
                    }
            match productsGot with
            | Ok products ->
                task
                    {
                        return products
                    }
            | Error error ->
                let productResponse = ServiceResponse<List<ProductType>>()
                productResponse.Message <- error
                task
                    {
                        return productResponse
                    }

        member this.AddProductType productType =
            let productAdded =
                result
                    {
                        let! productAdded =
                            runInit<ProductType, ProductTypeEvents, string> eventStore MessageSenders.NoSender productType
                        return ()    
                    }
            match productAdded with
            | Ok () ->
                (this :> IProductTypeService).GetProductTypes ()
            | Error error ->
                let productResponse = ServiceResponse<List<ProductType>>()
                productResponse.Message <- error
                task
                    {
                        return productResponse    
                    }
        member this.UpdateProductType(productType) =
            let productUpdated =
                result
                    {
                        let updateCommand = ProductTypeCommands.UpdateProductType productType
                        let! productUpdated = runAggregateCommand<ProductType, ProductTypeEvents, string> productType.Id eventStore MessageSenders.NoSender updateCommand
                        return ()    
                    }
            let productResponse = ServiceResponse<ProductType>()
            match productUpdated with
            | Ok () ->
                productResponse.Success <- true
                productResponse.Message <- "Product type updated successfully."
                productResponse.Data = productType
                task
                    {
                        return productResponse    
                    }
            | Error error ->
                productResponse.Success <- false
                productResponse.Message <- error
                task
                    {
                        return productResponse
                    }

        
