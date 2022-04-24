-- https://platform.stratascratch.com/coding/10313-naive-forecasting

with request_logs_per_month as (
    select
        to_char(request_date, 'yyyy-mm') as year_and_month,
        sum(distance_to_travel) as distance_to_travel,
        sum(monetary_cost) as monetary_cost
    from uber_request_logs
    group by 1
),

monthly_naive_forecast as (
    select
        year_and_month,
        distance_to_travel / monetary_cost as actual_distance_per_dollar,
        lag(
            distance_to_travel / monetary_cost, 1
        ) over(order by year_and_month) as forecasted_distance_per_dollar
    from request_logs_per_month
)

select round(
        sqrt(
            avg(
                power(
                    actual_distance_per_dollar - forecasted_distance_per_dollar,
                    2
                )
            )
        )::decimal,
        2
    ) as rmse
from monthly_naive_forecast
