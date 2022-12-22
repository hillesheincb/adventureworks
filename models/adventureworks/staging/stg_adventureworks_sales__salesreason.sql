with
    renamed as (
        select
            salesreasonid as salesreason_id
            , reasontype as salesreason_type
        from {{ source('adventureworks','sales_salesreason') }}
    )
select *
from renamed
