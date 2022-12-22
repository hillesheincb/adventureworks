with
    renamed as (
        select
            productid as product_id
            , name as product_name
        from {{ source('adventureworks','production_product') }}
    )
select *
from renamed
