-- DAY 9: CTE - WITH CLAUSE
-- Purpose: Pehle daily volume nikalo, phir uspe rank lagao

WITH daily_volume AS (
  -- Step 1: Har trader ka roz ka volume
  SELECT 
    date_trunc('day', tr.trade_date) as "Date",
    t.name as "Trader Name",
    SUM(tr.amount) as "Daily Volume"
  FROM ethereum.traders t
  JOIN ethereum.trades tr ON t.id = tr.trader_id
  WHERE tr.trade_date >= now() - INTERVAL '10' day
  GROUP BY 1, 2
)

-- Step 2: Us result pe har din ka rank
SELECT 
  *,
  RANK() OVER (
    PARTITION BY "Date" 
    ORDER BY "Daily Volume" DESC
  ) as "Daily Rank"
FROM daily_volume
ORDER BY "Date", "Daily Volume" DESC;
