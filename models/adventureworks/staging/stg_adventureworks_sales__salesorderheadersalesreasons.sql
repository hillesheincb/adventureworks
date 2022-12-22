with
    renamed as (
        select
            salesorderid as salesorder_id
            , salesreasonid as salesreason_id
        from {{ source('adventureworks','sales_salesorderheadersalesreason') }}
    )
select *
from renamed
