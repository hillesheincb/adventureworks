with
    renamed as (
        select
            countryregioncode as countryregion_code
            , name as country_name
        from {{ source('adventureworks','person_countryregion') }}
    )
select *
from renamed
