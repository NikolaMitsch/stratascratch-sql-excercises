-- https://platform.stratascratch.com/coding/9701-3rd-most-reported-health-issues

with health_inspections_by_facility_type_ranked as (
    select
        pe_description,
        rank() over(order by count(*) desc) as ranking
    from los_angeles_restaurant_health_inspections
    group by 1
)

select facility_name
from los_angeles_restaurant_health_inspections
where
    (lower(facility_name) like '%cafe%'
        or lower(facility_name) like '%tea%'
        or lower(facility_name) like '%juice%'
    )
    and pe_description in (
        select pe_description
        from health_inspections_by_facility_type_ranked where ranking = 3
    )
