-- https://platform.stratascratch.com/coding/9952-name-to-medal-connection

select
    length(name) as num_of_letters_in_name,
    sum(case when medal is null then 1 else 0 end) as no_medals,
    sum(case when medal = 'Bronze' then 1 else 0 end) as bronze_medals,
    sum(case when medal = 'Silver' then 1 else 0 end) as silver_medals,
    sum(case when medal = 'Gold' then 1 else 0 end) as gold_medals
from olympics_athletes_events
group by 1
order by 1
