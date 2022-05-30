-- https://platform.stratascratch.com/coding/10062-fans-vs-opposition

with employees_ranked_by_popularity as (
    select
        employee_id,
        rank() over(order by popularity asc, employee_id asc) as asc_ranking,
        rank() over(order by popularity desc, employee_id asc) as desc_ranking
    from facebook_hack_survey
)

select concat('(', e1.employee_id, ',', e2.employee_id, ')') as pairings
from employees_ranked_by_popularity as e1
inner join
    employees_ranked_by_popularity as e2 on e1.asc_ranking = e2.desc_ranking
