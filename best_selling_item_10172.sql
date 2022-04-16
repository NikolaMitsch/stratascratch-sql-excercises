-- https://platform.stratascratch.com/coding/10172-best-selling-item

WITH item_sales_ranked_by_month AS (
    SELECT
        description,
        EXTRACT(MONTH FROM invoicedate) invoice_month,
        unitprice * quantity total_amount,
        rank() over(partition BY EXTRACT(MONTH FROM invoicedate) ORDER BY unitprice * quantity DESC) rank
    FROM online_retail
                                   )
SELECT
    invoice_month,
    description,
    total_amount
FROM item_sales_ranked_by_month
WHERE rank = 1
