with
    renamed as (
        select distinct
            customerid as customer_id
            , coalesce(personid, 0) as person_id
            , territoryid as territory_id
        from {{ source('adventureworks','sales_customer') }}
    )
select *
from renamed
