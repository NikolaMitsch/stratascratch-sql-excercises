-- https://platform.stratascratch.com/coding/9822-find-the-average-number-of-friends-a-user-has

select
    user_id,
    count(friend_id) as num_of_friends
from google_friends_network
group by 1
order by 1
