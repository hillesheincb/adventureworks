with
    dim_addresses as (
        select distinct
            address_id
            , stateprovince_id
            , city_name        
        from {{ ref('stg_adventureworks_person__addresses') }}
    )
    , dim_countryregions as (
        select distinct
            countryregion_code
            , country_name
        from {{ ref('stg_adventureworks_person__countryregions') }}
    )
    , dim_territories as (
        select distinct
            businessentity_id
            , territory_id
        from {{ ref('stg_adventureworks_sales__salesterritoryhistories') }}
    )
    , dim_stateprovinces as (
        select distinct
            stateprovince_id
            , territory_id
            , countryregion_code
            , stateprovince_name
        from {{ ref('stg_adventureworks_person__stateprovinces') }}
    )
    , dim_completeaddresses as (
        select distinct
            dim_territories.territory_id as territory_id
            , dim_countryregions.countryregion_code as countryregion_code
            , dim_countryregions.country_name as country_name
            , dim_addresses.stateprovince_id as stateprovince_id
            , dim_stateprovinces.stateprovince_name as stateprovince_name
            , dim_addresses.address_id as address_id
            , dim_addresses.city_name as city_name
            , concat(country_name, stateprovince_name, address_id, city_name) as location_id
        from dim_stateprovinces
        left join dim_addresses on dim_stateprovinces.stateprovince_id = dim_addresses.stateprovince_id
        left join dim_territories on dim_stateprovinces.territory_id = dim_territories.territory_id
        left join dim_countryregions on dim_stateprovinces.countryregion_code = dim_countryregions.countryregion_code
    )
    , dim_location_sk as (
        select
            row_number () over (order by location_id) as location_sk
            , *
        from dim_completeaddresses
    )
select *
from dim_location_sk
