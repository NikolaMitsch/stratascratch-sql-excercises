-- https://platform.stratascratch.com/coding/2073-popular-posts

with view_time_per_post as (
    select
        v.post_id,
        sum(
            (s.session_endtime - s.session_starttime) / 100 * v.perc_viewed
        ) as view_time
    from user_sessions as s
    inner join post_views as v on v.session_id = s.session_id
    group by 1
)

select
    post_id,
    view_time
from view_time_per_post
where view_time > '5 sec'::interval
order by 2 desc
