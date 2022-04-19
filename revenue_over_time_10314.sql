-- https://platform.stratascratch.com/coding/10314-revenue-over-time

with total_sales_by_month as (
    select
        to_char(created_at, 'yyyy-mm') as year_and_month,
        sum(purchase_amt) as total_amount
    from amazon_purchases
    where purchase_amt >= 0
    group by 1
)

select
    year_and_month,
    avg(
        total_amount
    ) over(
        order by year_and_month asc rows between 2 preceding and current row
    ) as three_month_rolling_average
from total_sales_by_month
