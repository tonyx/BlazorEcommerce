namespace BlazorEcommerce.ServerFs.Services

open System.Threading.Tasks
open BlazorEcommerce.SharedFs
open BlazorEcommerce.SharedFs.Aliases

type IOrderService =
    abstract member PlaceOrder: UserId -> Task<ServiceResponse<bool>>
    abstract member GetOrders: unit -> Task<ServiceResponse<List<OrderOverviewResponse>>>
    abstract member GetOrderDetails: OrderId -> Task<ServiceResponse<OrderDetailsResponse>>
    
    