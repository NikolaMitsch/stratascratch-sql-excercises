-- https://platform.stratascratch.com/coding/9605-find-the-average-rating-of-movie-stars

with avg_movie_star_rating as (
    select
        name,
        coalesce(avg(rating), 0) as avg_rating
    from nominee_filmography
    group by 1
)

select
    avg_movie_star_rating.name,
    nominee_information.birthday,
    avg_movie_star_rating.avg_rating
from avg_movie_star_rating
inner join
    nominee_information on
        nominee_information.name = avg_movie_star_rating.name
order by 2
