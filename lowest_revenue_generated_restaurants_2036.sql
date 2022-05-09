-- https://platform.stratascratch.com/coding/2036-lowest-revenue-generated-restaurants

with revenue_by_restaurant_may_2020 as (
    select
        restaurant_id,
        sum(order_total) as total_revenue,
        ntile(50) over(order by sum(order_total) desc) as ntile_ranking
    from doordash_delivery
    where to_char(customer_placed_order_datetime, 'yyyy-mm') = '2020-05'
    group by 1
)
select
    restaurant_id,
    total_revenue
from revenue_by_restaurant_may_2020
where ntile_ranking = 50
