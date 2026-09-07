-- DAY 8: JOIN + WINDOW FUNCTION
-- Purpose: Har din ka Top 1 Trader nikalna

SELECT 
  date_trunc('day', tr.trade_date) as "Date",
  t.name as "Trader Name",
  SUM(tr.amount) as "Daily Volume",
  RANK() OVER (
    PARTITION BY date_trunc('day', tr.trade_date) 
    ORDER BY SUM(tr.amount) DESC
  ) as "Daily Rank"
FROM ethereum.traders t
JOIN ethereum.trades tr ON t.id = tr.trader_id
WHERE tr.trade_date >= now() - INTERVAL '10' day
GROUP BY 1, 2
ORDER BY 1, 3 DESC;
