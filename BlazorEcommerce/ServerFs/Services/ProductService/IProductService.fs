namespace BlazorEcommerce.ServerFs.Services
open BlazorEcommerce.SharedFs.Models

open System
open System.Threading.Tasks
open BlazorEcommerce.SharedFs
open BlazorEcommerce.SharedFs.Aliases
   
type IProductService =
    abstract member GetProductsAsync: unit -> Task<ServiceResponse<List<Product>>>
    abstract member GetProductAsync: ProductId -> Task<ServiceResponse<Product>>
    abstract member GetProductsByCategory: UrlString -> Task<ServiceResponse<List<Product>>>
    abstract member SearchProducts: string * int -> Task<ServiceResponse<ProductSearchResult>>
    abstract member GetProductSearchSuggestions: string -> Task<ServiceResponse<List<string>>>
    abstract member GetFeaturedProducts: unit -> Task<ServiceResponse<List<Product>>>
    abstract member GetAdminProducts: unit -> Task<ServiceResponse<List<Product>>>
    abstract member CreateProduct: Product -> Task<ServiceResponse<Product>>
    abstract member UpdateProduct: Product -> Task<ServiceResponse<Product>>
    abstract member DeleteProduct: ProductId -> Task<ServiceResponse<bool>>
    

