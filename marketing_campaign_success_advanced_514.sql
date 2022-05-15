-- https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced

with app_purchases_with_first_purchase_date as (
    select
        user_id,
        created_at,
        product_id,
        first_value(
            created_at
        ) over(partition by user_id order by created_at) as first_purchase_date
    from marketing_campaign
)

select count(distinct p.user_id)
from app_purchases_with_first_purchase_date as p
where p.created_at != p.first_purchase_date
    and p.product_id not in
    (select c.product_id
        from marketing_campaign as c
        where c.created_at = p.first_purchase_date and c.user_id = p.user_id
    )
