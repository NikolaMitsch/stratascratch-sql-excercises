-- https://platform.stratascratch.com/coding/10037-find-favourite-wine-variety

with tasters_favorite_varieties_ranked as (
    select
        taster_name,
        variety,
        rank() over(partition by taster_name order by count(*) desc) as ranking
    from winemag_p2
    where taster_name is not null
    group by 1, 2
)

select
    taster_name,
    variety
from tasters_favorite_varieties_ranked
where ranking = 1
