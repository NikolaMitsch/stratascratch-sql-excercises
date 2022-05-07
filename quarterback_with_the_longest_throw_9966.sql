-- https://platform.stratascratch.com/coding/9966-quarterback-with-the-longest-throw

with longest_throw_in_2016 as (
    select lg
    from qbstats_2015_2016
    where year = 2016
    order by cast(regexp_replace(lg, 't', '', 'g') as int) desc -- noqa: L054
    limit 1
)

select
    qb,
    lg
from qbstats_2015_2016
where year = 2016 and lg = (select lg from longest_throw_in_2016)
