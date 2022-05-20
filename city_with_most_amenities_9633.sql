-- https://platform.stratascratch.com/coding/9633-city-with-most-amenities

with apartments_with_num_of_amenities as (
    select
        id,
        city,
        array_length(
            string_to_array(regexp_replace(amenities, '[{}"]', '', 'g'), ','), 1
        ) as num_of_amenities
    from airbnb_search_details
),

cities_with_num_of_amenities_ranked as (
    select
        city,
        rank() over(order by sum(num_of_amenities) desc) as ranking
    from apartments_with_num_of_amenities
    group by 1
)

select city
from cities_with_num_of_amenities_ranked
where ranking = 1
