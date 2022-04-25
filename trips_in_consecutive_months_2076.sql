-- https://platform.stratascratch.com/coding/2076-trips-in-consecutive-months

with unique_complete_trips as (
    select distinct
        driver_id,
        date_trunc('month', trip_date)::date as year_and_month
    from uber_trips
    where is_completed
),

trips_in_consecutive_months as (
    select
        driver_id,
        year_and_month - lag(
            year_and_month, 1
        ) over(
            partition by driver_id order by year_and_month
        ) as days_since_last_trip
    from unique_complete_trips
)

select distinct driver_id
from trips_in_consecutive_months
where days_since_last_trip <= 31
order by 1
