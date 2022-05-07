-- https://platform.stratascratch.com/coding/2028-new-and-existing-users

with users_monthly_usage as (
    select distinct
        user_id,
        extract(month from time_id) as month_part
    from fact_events
),

users_with_num_of_month_using_service as (
    select
        month_part,
        user_id,
        rank() over(
            partition by user_id order by month_part
        ) as num_of_usage_months
    from users_monthly_usage
)

select
    month_part,
    sum(
        case when num_of_usage_months = 1 then 1 else 0 end
    ) / count(*)::decimal as share_of_new_users,
    sum(
        case when num_of_usage_months > 1 then 1 else 0 end
    ) / count(*)::decimal as share_of_existing_users
from users_with_num_of_month_using_service
group by 1
order by 1
