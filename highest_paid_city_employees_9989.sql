-- https://platform.stratascratch.com/coding/9989-highest-paid-city-employees

with employees_ranked_by_pay_per_job_title as (
    select
        jobtitle,
        employeename,
        rank() over(
            partition by
                jobtitle
            order by totalpaybenefits desc, employeename asc
        ) as ranking
    from sf_public_salaries
)

select
    jobtitle,
    max(
        case when ranking = 1 then employeename end
    ) as highest_paid_employee,
    max(
        case when ranking = 2 then employeename end
    ) as second_highest_paid_employee
from employees_ranked_by_pay_per_job_title
group by 1
order by 1
