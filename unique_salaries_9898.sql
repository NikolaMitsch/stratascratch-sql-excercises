-- https://platform.stratascratch.com/coding/9898-unique-salaries

with employees_ranked as (
    select
        department,
        salary,
        dense_rank() over(
            partition by department order by salary desc
        ) as ranking
    from twitter_employee
)

select distinct
    department,
    salary
from employees_ranked
where ranking <= 3
order by 1 asc, 2 desc
