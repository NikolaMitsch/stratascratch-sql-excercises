-- https://platform.stratascratch.com/coding/2054-consecutive-days

with usage_with_next_three_active_days as (
    select distinct
        date,
        user_id,
        lead(date, 0) over user_window as first_day_active,
        lead(date, 1) over user_window as second_day_active,
        lead(date, 2) over user_window as third_day_active
    from sf_events
    window user_window as (partition by user_id order by date)
)

select distinct user_id
from usage_with_next_three_active_days
where first_day_active is not null
    and second_day_active is not null
    and third_day_active is not null
    and second_day_active - first_day_active = 1
    and third_day_active - second_day_active = 1
