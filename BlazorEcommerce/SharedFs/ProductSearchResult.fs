namespace BlazorEcommerce.SharedFs

open System
open BlazorEcommerce.SharedFs.Models

type ProductSearchResult =
    {
        Products: List<Product>
        Pages: int
        CurrentPage: int
    }


