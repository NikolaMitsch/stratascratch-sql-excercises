-- https://platform.stratascratch.com/coding/10081-find-the-number-of-employees-who-received-the-bonus-and-who-didnt

select
    case
        when id in (
            select worker_ref_id
            from bonus) then 1
        else 0
    end as received_bonus,
    count(*) as num_of_employees
from employee
group by 1
