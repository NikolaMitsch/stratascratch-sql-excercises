-- https://platform.stratascratch.com/coding/10302-distance-per-dollar

with requests_with_dpd as (
    select
        request_date,
        to_char(request_date, 'yyyy-mm') as year_and_month,
        (distance_to_travel + driver_to_client_distance) / monetary_cost as dpd
    from uber_request_logs
),

requests_with_avg_monthly_dpd as (
    select
        request_date,
        dpd,
        avg(dpd) over(partition by year_and_month) as avg_monthly_dpd
    from requests_with_dpd
)

select
    request_date,
    round(abs(dpd - avg_monthly_dpd)::DECIMAL, 2) as daily_minus_avg_monthly_dpd
from requests_with_avg_monthly_dpd
order by 1
