with
    renamed as (
        select
            businessentityid as businessentity_id
            , territoryid as territory_id
        from {{ source('adventureworks','sales_salesterritoryhistory') }}
    )
select *
from renamed
