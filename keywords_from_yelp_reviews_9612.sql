-- https://platform.stratascratch.com/coding/9612-keywords-from-yelp-reviews

select
    b.name,
    b.address,
    b.state
from yelp_business as b
inner join yelp_reviews as r on r.business_name = b.name
where
    r.review_text ilike '%food%'
    or r.review_text ilike '%pizza%'
    or r.review_text ilike '%sandwich%'
    or r.review_text ilike '%burger%'
