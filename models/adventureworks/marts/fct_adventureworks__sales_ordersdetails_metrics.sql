with
    dim_orders as (
        select
            order_sk
            , salesorder_id
        from {{ ref('dim_adventureworks__sales_orders') }}
    )
    , dim_products as (
        select
            product_sk
            , product_id
        from {{ ref('dim_adventureworks__products') }}
    )
    , metrics as (
        select
            salesorder_id
            , product_id
            , specialoffer_id
            , order_qty
            , unit_price
            , order_total_value
        from {{ ref('stg_adventureworks_sales__salesorderdetails') }}
    )    
    , fact_source as (
        select
            {{ concat(['product_sk', 'order_sk']) }} as metric_sk
            , dim_orders.order_sk as order_fk
            , dim_products.product_sk as product_fk
            , metrics.salesorder_id
            , metrics.specialoffer_id
            , metrics.order_qty
            , metrics.unit_price
            , metrics.order_total_value
        from metrics
        left join dim_orders on metrics.salesorder_id = dim_orders.salesorder_id
        left join dim_products on metrics.product_id = dim_products.product_id
    )
select *
from fact_source
