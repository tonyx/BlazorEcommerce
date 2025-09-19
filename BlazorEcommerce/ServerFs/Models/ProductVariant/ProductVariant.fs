namespace BlazorEcommerce.ServerFs.Models

open System
open Sharpino
open Sharpino.Commons
open Sharpino.Core

module ProductVariant =
    type ProductVariant =
        {
            Id: Guid
            ProductId: Guid
            ProductTypeId: Guid
            Price: decimal
            OriginalPrice: decimal
            Visible: bool
            Deleted: bool
            Editing: bool
            IsNew: bool
        }
        with
            static member MkVariant (productId: Guid, productTypeId: Guid, price: decimal, originalPrice: decimal) =
                {
                    Id = Guid.NewGuid()
                    ProductId = productId
                    ProductTypeId = productTypeId
                    Price = price
                    OriginalPrice = originalPrice
                    Visible = true
                    Deleted = false
                    Editing = false
                    IsNew = true
                }
            member this.Update (variant: ProductVariant) =
                variant |> Ok
            member this.Serialize = jsonPSerializer.Serialize this
            static member SnapshotsInterval = 1000
            static member StorageName = "_productVariant"
            static member Version = "_01"
            
            static member Deserialize x: Result<ProductVariant, string> =
                jsonPSerializer.Deserialize<ProductVariant> x
            
            interface Aggregate<string> with
                member this.Id = this.Id
                member this.Serialize = this.Serialize
