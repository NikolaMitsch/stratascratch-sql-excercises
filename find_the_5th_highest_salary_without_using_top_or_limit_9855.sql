-- https://platform.stratascratch.com/coding/9855-find-the-5th-highest-salary-without-using-top-or-limit

with salaries_ranked as (
    select
        salary,
        dense_rank() over(order by salary desc) as ranking
    from worker
)

select salary
from salaries_ranked
where ranking = 5
