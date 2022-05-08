-- https://platform.stratascratch.com/coding/2007-rank-variance-per-country

with num_of_comments_per_country_and_month as (
    select
        u.country,
        to_char(c.created_at, 'yyyy-mm') as year_and_month_part,
        sum(c.number_of_comments) as num_of_comments
    from fb_comments_count as c
    inner join fb_active_users as u on u.user_id = c.user_id
    group by 1, 2
),

countries_ranked_by_num_of_comments as (
    select
        country,
        year_and_month_part,
        dense_rank() over(
            partition by year_and_month_part order by num_of_comments desc
        ) as ranking
    from num_of_comments_per_country_and_month
    where year_and_month_part in ('2019-12', '2020-01')
)

select c1.country
from countries_ranked_by_num_of_comments as c1
inner join
    countries_ranked_by_num_of_comments as c2 on
        c1.country = c2.country
        and c1.year_and_month_part < c2.year_and_month_part
where c1.ranking > c2.ranking
