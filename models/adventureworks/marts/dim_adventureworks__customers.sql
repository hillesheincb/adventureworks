with
    dim_persons as (
        select
            person_id
            , person_completename        
        from {{ ref('stg_adventureworks_person__persons') }}
    )
    , dim_customers as (
        select
            customer_id
            , person_id
        from {{ ref('stg_adventureworks_sales__customers') }}
    )
    , dim_person_complete as (
        select
            dim_customers.person_id
            , dim_customers.customer_id
            , dim_persons.person_completename
        from dim_customers
        left join dim_persons on dim_customers.person_id = dim_persons.person_id
    )
    , dim_data_identifications as (
        select
            row_number () over (order by customer_id) as customer_sk
            , customer_id
            , person_id
            , person_completename
        from dim_person_complete
        where person_completename is not null
    )
select *
from dim_data_identifications
