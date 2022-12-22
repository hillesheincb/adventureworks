with
    renamed as (
        select
            salesorderid as salesorder_id
            , productid as product_id
            , specialofferid as specialoffer_id
            , orderqty as order_qty
            , cast(unitprice as float64) as unit_price
            , (orderqty*unitprice) as order_total_value
        from {{ source('adventureworks','sales_salesorderdetail') }}
    )
select *
from renamed
