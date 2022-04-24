-- https://platform.stratascratch.com/coding/10013-positive-ad-channels

with ad_channels_ranked_by_max_yearly_spent as (
    select
        advertising_channel,
        rank() over(order by max(money_spent)) as ranking
    from uber_advertising
    where customers_acquired > 1500
    group by 1
    having count(*) = (select count(distinct year) from uber_advertising)
)

select advertising_channel
from ad_channels_ranked_by_max_yearly_spent
where ranking = 1
