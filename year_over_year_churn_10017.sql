-- https://platform.stratascratch.com/coding/10017-year-over-year-churn

with churn_per_year as (
    select
        extract(year from end_date) as year_part,
        count(*)::integer as churn
    from lyft_drivers
    where end_date is not null
    group by 1
    order by 1
),

churn_curr_and_prev_year as (
    select
        year_part,
        churn as churn_curr_year,
        lag(churn, 1, 0) over(order by year_part) as churn_prev_year
    from churn_per_year
)

select
    year_part,
    churn_curr_year,
    churn_prev_year,
    case
        when
            churn_curr_year > churn_prev_year then 'increase'
        when churn_curr_year < churn_prev_year then 'decrease'
        else 'no change'
    end as churn_year_over_year
from churn_curr_and_prev_year
