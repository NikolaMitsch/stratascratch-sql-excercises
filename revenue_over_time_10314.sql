-- https://platform.stratascratch.com/coding/10314-revenue-over-time

WITH total_sales_by_month AS (
    SELECT
        to_char(created_at, 'yyyy-mm') year_month,
        SUM(purchase_amt) total_amount
    FROM amazon_purchases
    WHERE purchase_amt >= 0
    GROUP BY 1
                             )
SELECT
    year_month,
    AVG(total_amount) over(ORDER BY year_month ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) three_month_rolling_average
FROM total_sales_by_month
