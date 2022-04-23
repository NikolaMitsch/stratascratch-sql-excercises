-- https://platform.stratascratch.com/coding/10019-find-the-probability-of-ordering-a-ride-based-on-the-weather-and-the-hour

with num_of_rides_per_weather_and_hour as (
    select
        weather,
        hour,
        count(*) as num_of_rides
    from lyft_rides
    group by 1, 2
)

select
    weather,
    hour,
    num_of_rides / sum(num_of_rides) over() as percentage_of_total_rides
from num_of_rides_per_weather_and_hour
order by 1, 2
