with
    renamed as (
        select
            productid as product_id
        from {{ source('adventureworks','production_productproductphoto') }}
    )
select *
from renamed
