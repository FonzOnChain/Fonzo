-- DAY 10: CASE WHEN
-- Purpose: Har trader ko volume ke hisab se tag karna

WITH daily_volume AS (
  SELECT 
    date_trunc('day', tr.trade_date) as "Date",
    t.name as "Trader Name",
    SUM(tr.amount) as "Daily Volume"
  FROM ethereum.traders t
  JOIN ethereum.trades tr ON t.id = tr.trader_id
  WHERE tr.trade_date >= now() - INTERVAL '10' day
  GROUP BY 1, 2
)

SELECT 
  *,
  CASE 
    WHEN "Daily Volume" > 100000 THEN 'Whale 🐋'
    WHEN "Daily Volume" > 10000 THEN 'Dolphin 🐬'
    WHEN "Daily Volume" > 1000 THEN 'Retail 🐟'
    ELSE 'Dust ✨'
  END as "Trader Type"
FROM daily_volume
ORDER BY "Daily Volume" DESC;
