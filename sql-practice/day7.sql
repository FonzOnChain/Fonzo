-- DAY 7: CASE WHEN
-- Purpose: 10 din mein total trade ke hisaab se category dena

SELECT 
  t.name as "Trader Name",
  COUNT(tr.id) as "Total Trades",
  SUM(tr.amount) as "Total Volume USD",
  CASE 
    WHEN SUM(tr.amount) > 100000 THEN '🐋 Whale'
    WHEN SUM(tr.amount) > 10000 THEN '🐬 Dolphin'
    ELSE '🐟 Fish'
  END as "Category"
FROM ethereum.traders t
JOIN ethereum.trades tr ON t.id = tr.trader_id
WHERE tr.trade_date >= now() - INTERVAL '10' day
GROUP BY 1
ORDER BY 3 DESC;
