namespace BlazorEcommerce.SharedFs

type ServiceResponse<'T> () =
    [<DefaultValue>]
    val mutable data : 'T
    
    [<DefaultValue>]
    val mutable success : bool

    [<DefaultValue>]
    val mutable message : string
    
    member this.Data
        with get () = this.data
        and set value = this.data <- value
        
    member this.Success
        with get () = this.success
        and set value = this.success <- value
        
    member this.Message
        with get () = this.message
        and set value = this.message <- value
    

    
    

