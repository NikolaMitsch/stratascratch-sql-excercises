-- https://platform.stratascratch.com/coding/2044-most-senior-junior-employee

with employees_with_tenure_ranked as (
    select
        hire_date,
        current_date - hire_date as tenure,
        rank() over(order by current_date - hire_date) as ranking_by_tenure_asc,
        rank() over(
            order by current_date - hire_date desc
        ) as ranking_by_tenure_desc
    from uber_employees
    where termination_date is null
)

select
    sum(
        case when ranking_by_tenure_desc = 1 then 1 else 0 end
    ) as num_of_employees_with_longest_tenure,
    sum(
        case when ranking_by_tenure_asc = 1 then 1 else 0 end
    ) as num_of_employees_with_least_tenure,
    (
        select distinct r.hire_date
        from
            employees_with_tenure_ranked as r
        where r.ranking_by_tenure_asc = 1
    ) - (
        select distinct r.hire_date
        from
            employees_with_tenure_ranked as r
        where r.ranking_by_tenure_desc = 1
    ) as num_of_days_between_longest_and_least_tenure
from employees_with_tenure_ranked
