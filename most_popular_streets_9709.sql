-- https://platform.stratascratch.com/coding/9709-most-popular-streets

with num_of_incidents_per_street_and_risk_category as (
    select
        trim(
            regexp_replace(facility_address, '[\d#]', '', 'g'), ''
        ) as street_name,
        substring(pe_description, '([A-Z]* RISK)') as risk_category,
        count(*) as num_of_incidents
    from los_angeles_restaurant_health_inspections
    group by 1, 2
),

num_of_incidents_per_street_and_risk_category_ranked as (
    select
        *,
        rank() over(
            partition by risk_category order by num_of_incidents desc
        ) as ranking
    from num_of_incidents_per_street_and_risk_category
)

select
    street_name,
    risk_category,
    num_of_incidents
from num_of_incidents_per_street_and_risk_category_ranked
where ranking = 1
