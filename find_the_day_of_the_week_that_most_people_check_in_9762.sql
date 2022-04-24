-- https://platform.stratascratch.com/coding/9762-find-the-day-of-the-week-that-most-people-check-in

select
    to_char(ds_checkin, 'day') as day_of_week,
    count(*) as check_in_count
from airbnb_contacts
group by 1
order by 2 desc
