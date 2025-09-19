namespace BlazorEcommerce.SharedFs

open System
open BlazorEcommmerce.SharedFs

type OrderDetailsResponse =
    {
        OrderDate: DateTime
        TotalPrice: decimal
        Products: List<OrderDetailsProductResponse>
    }

