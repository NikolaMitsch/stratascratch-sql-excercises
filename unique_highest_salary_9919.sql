-- https://platform.stratascratch.com/coding/9919-unique-highest-salary

select salary
from employee
group by 1
having count(*) = 1
order by 1 desc
limit 1
