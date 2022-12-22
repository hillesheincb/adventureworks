 with
    dim_salesorder_reasons as (
        select
            salesreason_id
            , salesreason_type
        from {{ ref('stg_adventureworks_sales__salesreasons') }}
    )
    , dim_salesorderheadersalesreasons as (
        select
            salesorder_id
            , salesreason_id
        from {{ ref('stg_adventureworks_sales__salesorderheadersalesreasons') }}
    )
    , dim_creditcards as (
        select
            creditcard_id
            , card_type    
        from {{ ref('stg_adventureworks_sales__creditcards') }}
    )
    , dim_salesorderheader as (
        select
            salesorder_id
            , customer_id
            , territory_id
            , address_id
            , creditcard_id
        from {{ ref('stg_adventureworks_sales__salesorderheaders') }}
    )
    , dim_reasons as (
        select
            dim_salesorderheadersalesreasons.salesorder_id
            , dim_salesorder_reasons.salesreason_id
            , dim_salesorder_reasons.salesreason_type
        from dim_salesorder_reasons
        left join dim_salesorderheadersalesreasons on dim_salesorder_reasons.salesreason_id = dim_salesorderheadersalesreasons.salesreason_id
    )
    , dim_sales_orders as (
        select
            dim_salesorderheader.salesorder_id
            , dim_salesorderheader.customer_id
            , dim_salesorderheader.territory_id
            , dim_salesorderheader.address_id
            , dim_creditcards.creditcard_id as creditcard_id
            , dim_creditcards.card_type as card_type
            , dim_reasons.salesreason_type
        from dim_salesorderheader
        left join dim_creditcards on dim_salesorderheader.creditcard_id = dim_creditcards.creditcard_id
        left join dim_reasons on dim_salesorderheader.salesorder_id = dim_reasons.salesorder_id
    )
    , dim_orders_sk as (
        select
            row_number () over (order by salesorder_id) as order_sk
            , *
        from dim_sales_orders
   )    
select *
from dim_orders_sk
