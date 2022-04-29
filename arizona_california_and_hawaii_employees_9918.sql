-- https://platform.stratascratch.com/coding/9918-arizona-california-and-hawaii-employees

with employees_ranked_by_name_per_city as (
    select
        first_name,
        city,
        rank() over(
            partition by city order by first_name, last_name, id
        ) as ranking
    from employee
),

employee_count_by_city as (
    select count(*) as employee_count
    from employee
    where city = 'Arizona' or city = 'California' or city = 'Hawaii'
    group by city -- noqa: L054
),

one_to_max_num_of_employees_per_city_series as (
    select generate_series(1,
        (
            select max(employee_count)
            from employee_count_by_city
        )
    ) as id
)

select
    a.first_name as arizona,
    c.first_name as california,
    h.first_name as hawaii
from one_to_max_num_of_employees_per_city_series as s
left join
    employees_ranked_by_name_per_city as a on a.ranking = s.id
left join
    employees_ranked_by_name_per_city as c on c.ranking = a.ranking
left join
    employees_ranked_by_name_per_city as h on h.ranking = c.ranking
where a.city = 'Arizona' and c.city = 'California' and h.city = 'Hawaii'
