-- https://platform.stratascratch.com/coding/2078-from-microsoft-to-google

with users_with_last_employer as (
    select
        user_id,
        employer as current_employer,
        lag(
            employer, 1
        ) over(partition by user_id order by start_date) as last_employer
    from linkedin_users
)

select count(distinct user_id) as num_of_direct_microsoft_to_google_switches
from users_with_last_employer
where current_employer = 'Google' and last_employer = 'Microsoft'
