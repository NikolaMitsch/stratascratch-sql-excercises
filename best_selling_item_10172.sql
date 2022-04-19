-- https://platform.stratascratch.com/coding/10172-best-selling-item

with item_sales_ranked_by_month as (
    select
        description,
        extract(month from invoicedate) as invoice_month,
        unitprice * quantity as total_amount,
        rank() over(
            partition by
                extract(month from invoicedate)
            order by unitprice * quantity desc
        ) as rank
    from online_retail
)

select
    invoice_month,
    description,
    total_amount
from item_sales_ranked_by_month
where rank = 1
