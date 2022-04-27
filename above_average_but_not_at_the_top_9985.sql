-- https://platform.stratascratch.com/coding/9985-above-average-but-not-at-the-top

with employees_with_salary_stats as (
    select
        employeename,
        totalpay,
        avg(
            totalpay
        ) over(partition by jobtitle) as average_total_pay_by_job_title,
        rank() over(
            partition by jobtitle order by totalpay desc
        ) as ranking_by_job_title
    from sf_public_salaries
    where year = '2013'
)

select employeename
from employees_with_salary_stats
where totalpay > average_total_pay_by_job_title and ranking_by_job_title > 5
