-- https://platform.stratascratch.com/coding/2033-find-the-most-profitable-location

with locations_avg_duration as (
    select
        location,
        avg(signup_stop_date - signup_start_date) as avg_duration
    from signups
    group by 1
),

locations_avg_revenue as (
    select
        s.location,
        avg(t.amt) as avg_revenue
    from signups as s
    inner join transactions as t on t.signup_id = s.signup_id
    group by 1
)

select
    d.location,
    d.avg_duration,
    r.avg_revenue,
    r.avg_revenue / d.avg_duration as avg_duration_and_revenue_ratio
from locations_avg_revenue as r
inner join locations_avg_duration as d on d.location = r.location
order by 4 desc
