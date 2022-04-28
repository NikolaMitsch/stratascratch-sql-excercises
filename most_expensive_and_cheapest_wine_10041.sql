-- https://platform.stratascratch.com/coding/10041-most-expensive-and-cheapest-wine

select distinct
    region_1,
    first_value(
        variety
    ) over region_window as most_expensive_price,
    last_value(
        variety
    ) over region_window as cheapest_price
from winemag_p1
where region_1 is not null
window
    region_window as (
        partition by
            region_1
        order by
            price desc
        rows between unbounded preceding and unbounded following
    )
