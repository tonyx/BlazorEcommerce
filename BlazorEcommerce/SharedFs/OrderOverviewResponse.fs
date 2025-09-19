namespace BlazorEcommerce.SharedFs

open System

type OrderOverviewResponse =
    {
        Id: Guid
        OrderDate: DateTime
        TotalPrice: decimal
        Product: string
        ProductImageUrl: string
    }