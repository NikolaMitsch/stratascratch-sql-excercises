-- https://platform.stratascratch.com/coding/10284-popularity-percentage

with friends_duplicated as (
    select
        user1,
        user2
    from facebook_friends union select
        user2 as user1,
        user1 as user2
    from facebook_friends
)

select
    user1,
    count(
        distinct user2
    )::decimal / count(*) over() * 100 as popularity_percent
from friends_duplicated
group by 1
order by 1
