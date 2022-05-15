-- https://platform.stratascratch.com/coding/2094-highest-earning-merchants

with highest_earning_merchants as (
    select
        m.name,
        cast(o.order_timestamp as date) as date_part,
        sum(o.total_amount_earned) as total_earnings
    from doordash_orders as o
    inner join doordash_merchants as m on m.id = o.merchant_id
    group by 1, 2
),

highest_earning_merchants_ranked_per_day as (
    select
        name,
        date_part,
        rank() over(
            partition by date_part order by total_earnings desc
        ) as ranking
    from highest_earning_merchants
)

select
    name,
    cast(date_part + interval '1 day' as date)
from highest_earning_merchants_ranked_per_day
where ranking = 1
