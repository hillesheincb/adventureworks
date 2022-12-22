with
    renamed as (
        select
            addressid as address_id
            , stateprovinceid as stateprovince_id
            , city as city_name
        from {{ source('adventureworks','person_address') }}
    )
select *
from renamed
