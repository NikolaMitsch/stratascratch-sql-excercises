-- https://platform.stratascratch.com/coding/2105-videos-removed-on-latest-date

with flag_reviews_with_latest_review_date as (
    select
        f.user_firstname,
        f.user_lastname,
        f.video_id,
        r.reviewed_outcome,
        r.reviewed_date,
        last_value(
            r.reviewed_date
        ) over(
            partition by
                f.user_firstname, f.user_lastname
            order by
                r.reviewed_date
            rows between unbounded preceding and unbounded following
        ) as latest_review_date
    from user_flags as f
    inner join flag_review as r on r.flag_id = f.flag_id
    where r.reviewed_by_yt
)

select
    user_firstname,
    user_lastname,
    latest_review_date,
    count(distinct video_id) as num_of_removed_videos
from flag_reviews_with_latest_review_date
where reviewed_outcome = 'REMOVED' and latest_review_date = reviewed_date
group by 1, 2, 3
