with
    renamed as (
        select
            creditcardid as creditcard_id
            , case
                when cardnumber like '1111%' then 'Vista'
                when cardnumber like '3333%' then 'Superior Card'
                when cardnumber like '5555%' then 'Distinguish'
                when cardnumber like '7777%' then 'Colonial Voice'
                else 'Other'
            end as card_type
        from {{ source('adventureworks','sales_creditcard') }}
    )
select *
from renamed
