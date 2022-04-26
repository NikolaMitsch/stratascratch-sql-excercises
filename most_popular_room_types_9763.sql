-- https://platform.stratascratch.com/coding/9763-most-popular-room-types

with searches_for_each_room_type as (
    select
        n_searches,
        unnest(string_to_array(filter_room_types, ',')) as room_type
    from airbnb_searches
)

select
    room_type,
    sum(n_searches) as total_n_searches
from searches_for_each_room_type
where room_type != ''
group by 1
order by 2 desc
