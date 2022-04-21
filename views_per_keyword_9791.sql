-- https://platform.stratascratch.com/coding/9791-views-per-keyword

select
    unnest(
        string_to_array(
            regexp_replace(facebook_posts.post_keywords, '[\[\]#]', '', 'g'),
            ','
        )) as keyword,
    count(*) as total_views
from facebook_posts
inner join
    facebook_post_views on facebook_post_views.post_id = facebook_posts.post_id
group by 1
order by 2 desc
