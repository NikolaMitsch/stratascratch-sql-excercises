-- https://platform.stratascratch.com/coding/10042-top-3-wineries-in-the-world

with winery_avg_points as (
    select
        winery,
        country,
        avg(points) as avg_points
    from winemag_p1
    group by 1, 2
),

winery_ranked as (
    select
        winery,
        country,
        avg_points,
        row_number() over(
            partition by country order by avg_points desc
        ) as ranking
    from winery_avg_points
),

distinct_countries as (
    select distinct country
    from winemag_p1
),

top_3 as (
    select
        1 as id,
        country
    from distinct_countries
    union all
    select
        2 as id,
        country
    from distinct_countries
    union all
    select
        3 as id,
        country
    from distinct_countries
)

select
    top_3.id,
    top_3.country,
    case
        when
            winery_ranked.winery is null
            and top_3.id = 2 then 'No second winery'
        when
            winery_ranked.winery is null
            and top_3.id = 3 then 'No third winery'
        else concat(winery_ranked.winery,
            '(', winery_ranked.avg_points::INTEGER, ')') end as winery
from top_3
left join winery_ranked
    on
        top_3.id = winery_ranked.ranking
        and top_3.country = winery_ranked.country
order by 2, 1
