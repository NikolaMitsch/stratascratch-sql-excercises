-- https://platform.stratascratch.com/coding/9857-find-the-second-highest-salary-without-using-order-by

with salaries_ranked as (
    select
        salary,
        dense_rank() over(order by salary desc) as ranking
    from worker
)

select salary
from salaries_ranked
where ranking = 2
