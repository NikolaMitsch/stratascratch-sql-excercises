-- https://platform.stratascratch.com/coding/9979-find-the-top-5-highest-paid-and-top-5-least-paid-employees-in-2012

with employees_ranked_by_salary_in_2020 as (
    select
        employeename,
        totalpaybenefits,
        rank() over(order by totalpaybenefits desc) as ranking_desc,
        rank() over(order by totalpaybenefits) as ranking_asc
    from sf_public_salaries
    where year = 2012
)

select
    employeename,
    totalpaybenefits
from employees_ranked_by_salary_in_2020
where ranking_desc <= 5 or ranking_asc <= 5
order by 2
