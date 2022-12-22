with
    renamed as (
        select
            specialofferid as specialoffer_id
            , productid as product_id
        from {{ source('adventureworks','sales_specialofferproduct') }}
    )
select *
from renamed
