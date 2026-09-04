-- DAY 5: JOIN 
-- Purpose: 2 table jorna + Top 5 traders nikalna

SELECT 
  t.name,
  SUM(tr.amount) as total_traded
FROM ethereum.traders t
JOIN ethereum.trades tr ON t.id = tr.trader_id
GROUP BY t.name
ORDER BY total_traded DESC
LIMIT 5;
