-- https://platform.stratascratch.com/coding/9606-differences-in-movie-ratings

with filmography_stats as (
    select
        name,
        avg(rating) over(partition by name) as average_lifetime_rating,
        nth_value(
            rating, 2
        ) over(order by id desc) as rating_from_second_biggest_id_film
    from nominee_filmography
    where role_type = 'Normal Acting'
)

select distinct
    name,
    average_lifetime_rating,
    rating_from_second_biggest_id_film,
    average_lifetime_rating - rating_from_second_biggest_id_film as difference
from filmography_stats
