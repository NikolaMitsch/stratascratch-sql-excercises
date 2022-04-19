-- https://platform.stratascratch.com/coding/10351-activity-rank

select
    from_user,
    count(*) as total_emails_sent,
    rank() over(order by count(*) desc, from_user) as activity_rank
from google_gmail_emails
group by 1
