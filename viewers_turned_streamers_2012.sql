-- https://platform.stratascratch.com/coding/2012-viewers-turned-streamers

with users_with_first_session_type as (
    select
        user_id,
        session_type,
        first_value(
            session_type
        ) over(
            partition by user_id order by session_start
        ) as first_session_type
    from twitch_sessions
)

select
    user_id,
    sum(
        case when session_type = 'streamer' then 1 else 0 end
    ) as num_of_streaming_sessions
from users_with_first_session_type
where first_session_type = 'viewer'
group by 1
order by 2 desc, 1
