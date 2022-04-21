-- https://platform.stratascratch.com/coding/9637-growth-of-airbnb

with hosts_registered_per_year as (
    select
        extract(year from host_since ) as year_part,
        count(*) as hosts_registered_curr_year
    from airbnb_search_details
    where host_since is not null
    group by 1
),

hosts_registered_year_comparison as (
    select
        year_part,
        hosts_registered_curr_year,
        lag(
            hosts_registered_curr_year
        ) over(order by year_part) as hosts_registered_prev_year
    from hosts_registered_per_year
)

select
    year_part,
    hosts_registered_curr_year,
    hosts_registered_prev_year,
    round((
        hosts_registered_curr_year - hosts_registered_prev_year
    ) / hosts_registered_prev_year::decimal * 100, 0) as growth_rate
from hosts_registered_year_comparison
order by 1
