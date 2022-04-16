-- https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices

WITH unique_apartments AS (
    SELECT
        price,
        CASE
            WHEN number_of_reviews = 0 THEN 'New'
            WHEN number_of_reviews BETWEEN 1 AND 5 THEN 'Rising'
            WHEN number_of_reviews BETWEEN 6 AND 15 THEN 'Trending Up'
            WHEN number_of_reviews BETWEEN 16 AND 40 THEN 'Popular'
            WHEN number_of_reviews > 40 THEN 'Hot'
        END host_pop_rating
    FROM airbnb_host_searches
    GROUP BY price, room_type, host_since, zipcode, number_of_reviews
                          )
SELECT
    host_pop_rating,
    MIN(price) min_price,
    AVG(price) avg_price,
    MAX(price) max_price
FROM unique_apartments
GROUP BY host_pop_rating
