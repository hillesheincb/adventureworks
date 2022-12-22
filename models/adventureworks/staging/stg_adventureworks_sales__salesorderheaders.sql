with
    renamed as (
        select distinct
            salesorderid as salesorder_id
            , customerid as customer_id
            , territoryid as territory_id
            , billtoaddressid as address_id
            , coalesce(creditcardid, 0) as creditcard_id
            , cast (orderdate as date) as order_date
            , status as order_status
        from {{ source('adventureworks','sales_salesorderheader') }}
    )
select *
from renamed
