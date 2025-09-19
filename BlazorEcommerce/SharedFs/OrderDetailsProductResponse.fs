namespace BlazorEcommmerce.SharedFs

open System

type OrderDetailsProductResponse =
    {
        ProductId: Guid
        Title: string
        ProductType: string
        ImageUrl: string
        Quantity: int
        TotalPrice: decimal
    }

