-- https://platform.stratascratch.com/coding/9959-olympic-medals-by-chinese-athletes

with chinese_athlete_medals as (
    select
        medal,
        games
    from olympics_athletes_events
    where year between 2000 and 2016
        and team = 'China'
        and not games = '2016 Winter'
        and medal is not null
)

select
    medal,
    games,
    count(*) as num_of_medals,
    (select count(*) from chinese_athlete_medals) as total_num_of_medals
from chinese_athlete_medals
group by 1, 2
order by 3 desc
