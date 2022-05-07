-- https://platform.stratascratch.com/coding/9955-norwegian-alpine-skiers

with norwegian_alpine_skiers as (
    select distinct name
    from olympics_athletes_events
    where team = 'Norway' and sport = 'Alpine Skiing'
)

select name
from norwegian_alpine_skiers as s
where (
    select count(o.id)
    from olympics_athletes_events as o
    where o.name = s.name and o.year = 1992
) >= 1 and (
    select count(o.id)
    from olympics_athletes_events as o
    where o.name = s.name and o.year = 1994
) = 0
