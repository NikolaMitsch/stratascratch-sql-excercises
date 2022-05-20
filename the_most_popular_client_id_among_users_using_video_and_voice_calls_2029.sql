-- https://platform.stratascratch.com/coding/2029-the-most-popular-client_id-among-users-using-video-and-voice-calls

with video_and_voice_call_users as (
    select user_id
    from fact_events
    group by 1
    having
        sum(
            case
                when
                    event_type in (
                        'video call received',
                        'video call sent',
                        'voice call received',
                        'voice call sent'
                    ) then 1
                else 0
            end
        ) / count(*)::decimal >= 0.5
),

client_ids_used_by_video_and_voice_users_ranked as (
    select
        client_id,
        rank() over(order by count(*) desc) as ranking
    from fact_events
    where user_id in (select user_id from video_and_voice_call_users)
    group by 1
)

select client_id
from client_ids_used_by_video_and_voice_users_ranked
where ranking = 1
