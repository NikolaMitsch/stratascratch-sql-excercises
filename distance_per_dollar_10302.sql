-- https://platform.stratascratch.com/coding/10302-distance-per-dollar

WITH requests_with_dpd AS (
    SELECT
        request_date,
        to_char(request_date, 'yyyy-mm') year_month,
        (distance_to_travel + driver_to_client_distance) / monetary_cost dpd
    FROM uber_request_logs
                          ), requests_with_avg_monthly_dpd AS (
    SELECT
        request_date,
        dpd,
        AVG(dpd) over(partition BY year_month) avg_monthly_dpd
    FROM requests_with_dpd
                                                              )
SELECT
    request_date,
    round(abs(dpd - avg_monthly_dpd)::DECIMAL, 2) daily_minus_avg_monthly_dpd
FROM requests_with_avg_monthly_dpd
ORDER BY request_date
