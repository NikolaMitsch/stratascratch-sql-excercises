-- https://platform.stratascratch.com/coding/9900-median-salary

WITH employee_with_department_size AS (
    SELECT
        department,
        salary,
        COUNT(*) over(partition BY department) department_size
    FROM employee
    WHERE salary IS NOT NULL
                                      ), employee_with_department_median_salary AS (
    SELECT
        department,
        CASE
            WHEN department_size % 2 = 0
                THEN (nth_value(salary, (department_size / 2):: INTEGER) OVER department_window + nth_value(salary, (department_size / 2 + 1)::INTEGER) OVER department_window) / 2
            ELSE nth_value(salary, (department_size / 2 + 1):: INTEGER) OVER department_window
        END median
    FROM employee_with_department_size
    WINDOW department_window AS (PARTITION BY department ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) )

SELECT DISTINCT
    department,
    median
FROM employee_with_department_median_salary
