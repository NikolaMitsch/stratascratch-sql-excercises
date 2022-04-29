-- https://platform.stratascratch.com/coding/9953-find-the-gender-ratio-between-the-number-of-men-and-women-who-participated-in-each-olympics

with num_of_men_and_woman_athletes_per_olympics as (
    select
        games,
        sum(case when sex = 'M' then 1 else 0 end) as num_of_men,
        sum(case when sex = 'F' then 1 else 0 end) as num_of_woman
    from olympics_athletes_events
    group by 1
)

select
    games,
    num_of_men,
    num_of_woman,
    case
        when num_of_woman != 0 then num_of_men / num_of_woman::decimal
    end as men_to_woman_ratio
from num_of_men_and_woman_athletes_per_olympics
order by 1
