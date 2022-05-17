-- https://platform.stratascratch.com/coding/9960-top-teams-in-the-rio-de-janeiro-2016-olympics

with rio_olympics_team_medals_per_event as (
    select
        event,
        team,
        sum(case when medal is not null then 1 else 0 end) as num_of_medals
    from olympics_athletes_events
    where year = 2016 and city = 'Rio de Janeiro'
    group by 1, 2
)

select distinct
    event,
    case when nth_value(team, 1) over event_window is not null then
        concat(
            nth_value(team, 1) over event_window,
            ' with ',
            nth_value(num_of_medals, 1) over event_window,
            ' medals'
        ) else 'No Team' end
    as golden_team,
    case when nth_value(team, 2) over event_window is not null then
        concat(
            nth_value(team, 2) over event_window,
            ' with ',
            nth_value(num_of_medals, 2) over event_window,
            ' medals'
        ) else 'No Team' end
    as silver_team,
    case when nth_value(team, 3) over event_window is not null then
        concat(
            nth_value(team, 3) over event_window,
            ' with ',
            nth_value(num_of_medals, 3) over event_window,
            ' medals'
        ) else 'No Team' end
    as bronze_team
from rio_olympics_team_medals_per_event
window
    event_window as (partition by event order by num_of_medals desc, team asc)
