namespace BlazorEcommerce.ServerFs.Services

open System.Threading.Tasks
open BlazorEcommerce.SharedFs.Models
open BlazorEcommerce.SharedFs.Aliases
open BlazorEcommerce.SharedFs

type ICategoryService =
    abstract member AddCategory: Category -> Task<ServiceResponse<List<Category>>>
    abstract member UpdateCategory: Category -> Task<ServiceResponse<List<Category>>>
    abstract member DeleteCategory: CategoryId -> Task<ServiceResponse<List<Category>>>
    abstract member GetCategories: unit -> Task<ServiceResponse<List<Category>>>
    abstract member GetAdminCategories: unit -> Task<ServiceResponse<List<Category>>>