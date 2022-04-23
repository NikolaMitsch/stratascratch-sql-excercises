-- https://platform.stratascratch.com/coding/10018-lyft-driver-salary-and-service-tenure

select corr(end_date - start_date, yearly_salary) as correlation
from lyft_drivers
