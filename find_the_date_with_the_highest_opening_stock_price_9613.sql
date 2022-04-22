-- https://platform.stratascratch.com/coding/9613-find-the-date-with-the-highest-opening-stock-price

select date
from aapl_historical_stock_price
where open = (select max(open) from aapl_historical_stock_price)
