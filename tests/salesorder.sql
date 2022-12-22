with
    data as (
        select
            customer_id
            , card_type
        from {{ ref('dim_adventureworks__sales_orders') }}
        where
           salesorder_id = 43666
    )
    , validation as (
        select *
        from data
        where
            customer_id != 30052
            or card_type not like 'Vista'
    )
select *
from validation
