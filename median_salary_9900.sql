-- https://platform.stratascratch.com/coding/9900-median-salary

with employee_with_department_size as (
    select
        department,
        salary,
        count(*) over(partition by department) as department_size
    from employee
    where salary is not null
),

employee_with_department_median_salary as (
    select
        department,
        case
            when department_size % 2 = 0
                then (
                    nth_value(
                        salary, (department_size / 2)::INTEGER
                    ) over department_window + nth_value(
                        salary, (department_size / 2 + 1)::INTEGER
                    ) over department_window
                ) / 2
            else
                nth_value(
                    salary, (department_size / 2 + 1)::INTEGER
                ) over department_window
        end as median
    from employee_with_department_size
    window
        department_window as (
            partition by
                department
            order by
                salary
            rows between unbounded preceding and unbounded following
        )
)

select distinct
    department,
    median
from employee_with_department_median_salary
