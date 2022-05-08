-- https://platform.stratascratch.com/coding/2053-retention-rate

with monthly_account_usages as (
    select distinct
        account_id,
        user_id,
        to_char(date, 'yyyy-mm') as year_and_month_part
    from sf_events
),

monthly_user_account_retention as (
    select
        year_and_month_part,
        account_id,
        user_id,
        case
            when
                last_value(
                    year_and_month_part
                ) over(
                    partition by
                        account_id, user_id
                    order by
                        year_and_month_part
                    rows between unbounded preceding and unbounded following
                ) > year_and_month_part then 1 else 0 end as is_retained
    from monthly_account_usages
)

select
    account_id,
    (sum(
        case
            when
                year_and_month_part = '2021-01' and is_retained = 1 then 1
            else 0
        end
    ) / sum(
        case when year_and_month_part = '2021-01' then 1 else 0 end
    )::decimal)
    / (sum(
        case
            when
                year_and_month_part = '2020-12' and is_retained = 1 then 1
            else 0
        end
    ) / sum(
        case when year_and_month_part = '2020-12' then 1 else 0 end
    )::decimal) as retention_rate_ratio_jan_2021_to_dec_2020
from monthly_user_account_retention
group by 1
