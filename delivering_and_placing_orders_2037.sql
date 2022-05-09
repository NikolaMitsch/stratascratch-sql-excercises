-- https://platform.stratascratch.com/coding/2037-delivering-and-placing-orders

with deliveries as (
    select
        order_total,
        extract(minutes from
            placed_order_with_restaurant_datetime
            - customer_placed_order_datetime
        ) as minutes_between_placement_and_restaurant_delivery
    from doordash_delivery
)

select corr(
        order_total, minutes_between_placement_and_restaurant_delivery
    ) as correlation
from deliveries
