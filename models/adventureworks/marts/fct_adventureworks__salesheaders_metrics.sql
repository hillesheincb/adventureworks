with
    dim_orders as (
        select
            order_sk
            , salesorder_id
        from {{ ref('dim_adventureworks__sales_orders') }}
    )
    , dim_customers as (
        select
            customer_sk
            , customer_id
        from {{ ref('dim_adventureworks__customers') }}
    )
    , dim_locations as (
        select
            location_sk
            , address_id
        from {{ ref('dim_adventureworks__locations') }}
    )
    , sh_metrics as (
        select
            salesorder_id
            , customer_id
            , territory_id
            , address_id
            , creditcard_id
            , order_date
            , order_status
        from {{ ref('stg_adventureworks_sales__salesorderheaders') }}
    )
    , fact_source_ as (
        select
            {{ concat(['customer_sk', 'order_sk', 'location_sk', ]) }} as metric_sk
            , dim_orders.order_sk as order_fk
            , dim_customers.customer_sk as customer_fk
            , dim_locations.location_sk as location_fk
            , sh_metrics.territory_id
            , sh_metrics.creditcard_id
            , sh_metrics.order_date
            , sh_metrics.order_status
        from sh_metrics
        left join dim_orders on sh_metrics.salesorder_id = dim_orders.salesorder_id
        left join dim_customers on sh_metrics.customer_id = dim_customers.customer_id
        left join dim_locations on sh_metrics.address_id = dim_locations.address_id
    )
select *
from fact_source_
