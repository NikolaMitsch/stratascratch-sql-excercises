-- https://platform.stratascratch.com/coding/9899-percentage-of-total-spend

with orders_with_total_customer_spend as (
    select
        cust_id,
        order_details,
        total_order_cost,
        sum(total_order_cost) over(partition by cust_id) as total_customer_spend
    from orders
)

select
    c.first_name,
    o.order_details,
    o.total_order_cost / o.total_customer_spend as percentage_of_total_spend
from orders_with_total_customer_spend as o
inner join customers as c on c.id = o.cust_id
order by 1, 2
