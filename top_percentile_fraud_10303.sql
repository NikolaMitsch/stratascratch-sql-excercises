-- https://platform.stratascratch.com/coding/10303-top-percentile-fraud

with claims_ranked_by_fraud_score as (
    select
        policy_num,
        state,
        claim_cost,
        fraud_score,
        percent_rank() over(
            partition by state order by fraud_score desc
        ) as percentile
    from fraud_score
)

select
    policy_num,
    state,
    claim_cost,
    fraud_score
from claims_ranked_by_fraud_score
where percentile < 0.05
