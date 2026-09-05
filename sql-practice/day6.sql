-- DAY 6: SUBQUERY
-- Purpose: Average se zyada trade karne wale traders

SELECT 
  t.name,
  SUM(tr.amount) as total_traded
FROM ethereum.traders t
JOIN ethereum.trades tr ON t.id = tr.trader_id
GROUP BY t.name
HAVING SUM(tr.amount) > (
  SELECT AVG(amount) FROM ethereum.trades
)
ORDER BY total_traded DESC;
