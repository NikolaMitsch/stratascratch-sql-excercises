-- https://platform.stratascratch.com/coding/2088-seat-availability

select
    s.seat_number,
    s.seat_right
from theater_seatmap as s
inner join theater_availability as a1 on a1.seat_number = s.seat_number
inner join theater_availability as a2 on a2.seat_number = s.seat_right
where a1.is_available and a2.is_available
