-- https://platform.stratascratch.com/coding/10300-premium-vs-freemium

with num_of_downloads_per_day as (
    select
        d.date,
        sum(
            case when a.paying_customer = 'no' then d.downloads else 0 end
        ) as non_paying_downloads,
        sum(
            case when a.paying_customer = 'yes' then d.downloads else 0 end
        ) as paying_downloads
    from ms_download_facts as d
    inner join ms_user_dimension as u on u.user_id = d.user_id
    inner join ms_acc_dimension as a on a.acc_id = u.acc_id
    group by 1
)

select
    date,
    non_paying_downloads,
    paying_downloads
from num_of_downloads_per_day
where non_paying_downloads > paying_downloads
order by 1
