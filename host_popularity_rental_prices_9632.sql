-- https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices

with unique_apartments as (
    select
        price,
        room_type,
        host_since,
        zipcode,
        number_of_reviews,
        case
            when number_of_reviews = 0 then 'New'
            when number_of_reviews between 1 and 5 then 'Rising'
            when number_of_reviews between 6 and 15 then 'Trending Up'
            when number_of_reviews between 16 and 40 then 'Popular'
            when number_of_reviews > 40 then 'Hot'
        end as host_pop_rating
    from airbnb_host_searches
    group by 1, 2, 3, 4, 5
)

select
    host_pop_rating,
    min(price) as min_price,
    avg(price) as avg_price,
    max(price) as max_price
from unique_apartments
group by 1
