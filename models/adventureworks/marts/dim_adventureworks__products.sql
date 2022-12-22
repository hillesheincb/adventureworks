with
    dim_salesorderdetails as (
        select
            salesorder_id
            , specialoffer_id
            , product_id
        from {{ ref('stg_adventureworks_sales__salesorderdetails') }}
    )
    , dim_specialofferproducts as (
        select
            specialoffer_id
            , product_id
        from {{ ref('stg_adventureworks_sales__specialofferproducts') }}
    )
    , dim_productproductphotos as (
        select
            product_id
        from {{ ref('stg_adventureworks_production__productproductphotos') }}
    )
    , dim_products as (
        select
            product_id
            , product_name        
        from {{ ref('stg_adventureworks_production__products') }}
    )
    , dim_combined_products as (
        select distinct
            dim_productproductphotos.product_id
            , dim_products.product_name
        from dim_products
        left join dim_productproductphotos on dim_products.product_id = dim_productproductphotos.product_id
    )
    , dim_combined_with_specialoffers as (
        select distinct
            dim_combined_products.product_id
            , dim_specialofferproducts.specialoffer_id
            , dim_combined_products.product_name
        from dim_specialofferproducts
        left join dim_combined_products on dim_specialofferproducts.product_id = dim_combined_products.product_id
    )
    , dim_completeproducts as (
        select distinct
             dim_combined_with_specialoffers.product_id as product_id
            , dim_combined_with_specialoffers.product_name as product_name
        from dim_salesorderdetails
        left join dim_combined_with_specialoffers on dim_combined_with_specialoffers.product_id = dim_salesorderdetails.product_id
        left join dim_specialofferproducts on dim_specialofferproducts.specialoffer_id = dim_salesorderdetails.specialoffer_id
    )
select
    row_number () over (order by product_id) as product_sk
    , *
from dim_completeproducts
