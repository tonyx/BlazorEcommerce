namespace BlazorEcommerce.SharedFs

open System

type CartProductResponse =
    {
        ProductId: Guid
        Title: string
        ProductTypeId: Guid
        Price: decimal
        ImageUrl: string
        Quantity: int
    }
        


