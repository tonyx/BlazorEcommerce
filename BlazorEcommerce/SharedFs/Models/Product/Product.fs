namespace BlazorEcommerce.SharedFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

type Product =
    {
        Id: Guid
        Title: string
        Description: string
        ImageUrl: string
        CategoryId: Guid
        ProductVariantIds: List<Guid>
        Featured: bool
        Visible: bool
        Deleted: bool
        Editing: bool
        IsNew: bool
    }
    with
        static member MkProduct (title: string, description: string, imageUrl: string, categoryId: Guid) =
            {
                Id = Guid.NewGuid()
                Title = title
                Description = description
                ImageUrl = imageUrl
                CategoryId = categoryId
                ProductVariantIds = []
                Featured = false
                Visible = true
                Deleted = false
                Editing = false
                IsNew = true
            }
            
        member this.Update (product: Product) =
            product |> Ok
        member this.Serialize = jsonPSerializer.Serialize this
        static member SnapshotsInterval = 1000
        static member StorageName = "_product"
        static member Version = "_01"
        
        static member Deserialize x: Result<Product, string> =
            jsonPSerializer.Deserialize<Product> x
        
        interface Aggregate<string> with
            member this.Id = this.Id
            member this.Serialize = this.Serialize    
                    

type ProductDetails =
    {
        Product: Product
        ProductCategory: Category
    }     