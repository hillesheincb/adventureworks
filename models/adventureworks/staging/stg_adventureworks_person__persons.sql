with
    renamed as (
        select
            businessentityid as person_id
          , concat(firstname, ' ', coalesce(middlename, ' '), ' ', lastname) as person_completename
        from {{ source('adventureworks','person_person') }}
    )
select *
from renamed
