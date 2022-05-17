-- https://platform.stratascratch.com/coding/9981-employees-without-benefits

with salary_stats_per_job_title as (
    select
        jobtitle,
        sum(
            case when benefits = 0 then 1 else 0 end
        ) as num_of_employees_without_benefits,
        count(*) as total_employees_with_job_title
    from sf_public_salaries
    group by 1
)

select
    jobtitle,
    num_of_employees_without_benefits,
    total_employees_with_job_title,
    num_of_employees_without_benefits
    / total_employees_with_job_title::decimal as benefits_ratio
from salary_stats_per_job_title
order by 4
