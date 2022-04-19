-- https://platform.stratascratch.com/coding/10351-activity-rank

SELECT
    from_user,
    COUNT(*) total_emails_sent,
    rank() over(ORDER BY COUNT(*) DESC, from_user) activity_rank
FROM google_gmail_emails
GROUP BY from_user
