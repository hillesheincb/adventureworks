with
    renamed as (
        select
            businessentityid as businessentity_id
            , addressid as address_id
        from {{ source('adventureworks','person_businessentityaddress') }}
    )
select *
from renamed
