namespace BlazorEcommerce.ServerFs.Services

open System.Threading.Tasks
open BlazorEcommerce.SharedFs
open BlazorEcommerce.SharedFs.Aliases
open BlazorEcommerce.SharedFs.Models

type IProductTypeService =
    abstract member GetProductTypes : unit -> Task<ServiceResponse<List<ProductType>>>
    abstract member UpdateProductType: ProductType -> Task<ServiceResponse<ProductType>>
    abstract member AddProductType : ProductType -> Task<ServiceResponse<List<ProductType>>>