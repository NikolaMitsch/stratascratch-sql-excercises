-- https://platform.stratascratch.com/coding/9784-time-between-two-events

with time_between_page_load_and_scroll_down_events_per_user as (
    select
        l1.user_id,
        l1.timestamp as page_load_time,
        l2.timestamp as first_scroll_down_time,
        l2.timestamp - l1.timestamp as difference
    from facebook_web_log l1
    inner join facebook_web_log l2
        on l1.user_id = l2.user_id
        and l1.timestamp < l2.timestamp
        and l1.action = 'page_load'
        and l2.action = 'scroll_down'
),

time_between_page_load_and_scroll_down_events_per_user_ranked as (
    select
        *,
        rank() over(order by difference) as ranking
    from time_between_page_load_and_scroll_down_events_per_user
)

select
    user_id,
    page_load_time,
    first_scroll_down_time,
    difference
from time_between_page_load_and_scroll_down_events_per_user_ranked
where ranking = 1
