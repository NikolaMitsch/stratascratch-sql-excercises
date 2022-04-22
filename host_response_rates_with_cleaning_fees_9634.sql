-- https://platform.stratascratch.com/coding/9634-host-response-rates-with-cleaning-fees

with response_rates_by_zipcode as (
    select
        zipcode,
        avg(
            cast(regexp_replace(host_response_rate, '%', '', 'g') as int)
        )::int as avg_response_rate
    from airbnb_search_details
    where cleaning_fee
    group by 1
    order by 2
)

select
    zipcode,
    concat(avg_response_rate, '%') as avg_response_rate
from response_rates_by_zipcode
where avg_response_rate is not null
