with
    renamed as (
        select
            stateprovinceid as stateprovince_id
            , territoryid as territory_id
            , countryregioncode as countryregion_code
            , name as stateprovince_name
        from {{ source('adventureworks','person_stateprovince') }}
    )
select *
from renamed
