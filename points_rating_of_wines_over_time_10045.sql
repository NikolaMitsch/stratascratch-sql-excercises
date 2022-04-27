-- https://platform.stratascratch.com/coding/10045-points-rating-of-wines-over-time

with years_from_2000 as (
    select extract(year from year_series.year_series)::int as year_part
    from
        generate_series(
            '2000-01-01', current_date, '1 year'::interval
        ) as year_series
),

avg_points_rating_per_year as (
    select
        y.year_part,
        coalesce(sum(m.points), 87) as avg_points
    from years_from_2000 as y
    left join
        winemag_p2 as m on substring(m.title, '[0-9]{4}')::int = y.year_part
    group by 1
),

avg_points_rating_year_over_year as (
    select
        year_part,
        avg_points as avg_points_curr_year,
        coalesce(
            lag(avg_points, 1) over(order by year_part), 87
        ) as avg_points_prev_year
    from avg_points_rating_per_year
    where year_part is not null and year_part >= 2000
)

select
    year_part,
    avg_points_curr_year,
    avg_points_prev_year,
    abs(avg_points_curr_year - avg_points_prev_year) as difference
from avg_points_rating_year_over_year
order by 1
