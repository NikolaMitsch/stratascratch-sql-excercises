-- https://platform.stratascratch.com/coding/9716-top-3-facilities

with avg_facility_score as (
    select
        owner_name,
        facility_address,
        avg(score) as avg_score
    from los_angeles_restaurant_health_inspections
    group by 1, 2
),

top_3_facilities as (
    select
        owner_name,
        rank() over owner_window as ranking,
        lead(facility_address, 0) over owner_window as top_1_facility_address,
        lead(facility_address, 1) over owner_window as top_2_facility_address,
        lead(facility_address, 2) over owner_window as top_3_facility_address
    from avg_facility_score
    window
        owner_window as (
            partition by
                owner_name
            order by avg_score desc, facility_address asc
        )
)

select
    owner_name,
    top_1_facility_address,
    top_2_facility_address,
    top_3_facility_address
from top_3_facilities
where ranking = 1
