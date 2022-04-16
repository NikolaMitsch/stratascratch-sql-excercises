-- https://platform.stratascratch.com/coding/10284-popularity-percentage

WITH friends_duplicated AS (
    SELECT user1, user2 FROM facebook_friends UNION SELECT user2 user1, user1 user2 FROM facebook_friends
                           )
SELECT
    user1,
    COUNT(DISTINCT user2) ::decimal / COUNT(1) over() * 100 popularity_percent
FROM friends_duplicated
GROUP BY user1
ORDER BY user1
