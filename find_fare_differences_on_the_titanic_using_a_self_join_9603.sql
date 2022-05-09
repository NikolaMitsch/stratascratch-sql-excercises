-- https://platform.stratascratch.com/coding/9603-find-fare-differences-on-the-titanic-using-a-self-join

select
    t1.name,
    avg(abs(t1.fare - t2.fare)) as avg_fare_difference
from titanic as t1
inner join titanic as t2
    on t2.passengerid != t1.passengerid
        and t2.pclass = t1.pclass
        and abs(t2.age - t1.age) <= 5
where t1.survived = 0 and t2.survived = 0
group by 1
order by 1
