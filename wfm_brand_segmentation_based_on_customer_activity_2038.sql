-- https://platform.stratascratch.com/coding/2038-wfm-brand-segmentation-based-on-customer-activity

with customer_stats_per_store_brand as (
    select
        s.store_brand,
        t.customer_id,
        sum(t.sales) as total_sales,
        count(distinct t.transaction_id) as total_transactions,
        sum(t.sales) / count(distinct t.transaction_id) as avg_basket_size
    from wfm_transactions as t
    inner join wfm_stores as s on s.store_id = t.store_id
    group by 1, 2
),

customer_segmentation_per_store_brand as (
    select
        *,
        case
            when avg_basket_size > 30 then 'High'
            when avg_basket_size between 20 and 30 then 'Medium'
            else 'Low'
        end as segment
    from customer_stats_per_store_brand
)

select
    store_brand,
    segment,
    count(customer_id) as num_of_customers,
    sum(total_transactions) as total_transactions,
    sum(total_sales) as total_sales,
    avg(avg_basket_size) as avg_basket_size
from customer_segmentation_per_store_brand
group by 1, 2
order by 1, 2
