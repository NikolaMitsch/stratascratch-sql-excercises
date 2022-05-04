-- https://platform.stratascratch.com/coding/10090-find-the-percentage-of-shipable-orders

with shipable_orders as (
    select orders.id
    from orders
    inner join customers on customers.id = orders.cust_id
    where customers.address is not null
)

select (
        select count(*) from shipable_orders
    ) / count(*)::decimal * 100 as percent_of_shipable_orders
from orders
