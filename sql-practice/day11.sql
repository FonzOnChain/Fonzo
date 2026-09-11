-- DAY 11: UNION
-- Purpose: Ethereum + Polygon ke trades ko ek sath dekhna

-- Part 1: Ethereum trades
SELECT 
  'Ethereum' as "Chain",
  t.name as "Trader",
  tr.amount as "Amount USD",
  tr.trade_date as "Date"
FROM ethereum.traders t
JOIN ethereum.trades tr ON t.id = tr.trader_id
WHERE tr.trade_date >= now() - INTERVAL '7' day

UNION ALL

-- Part 2: Polygon trades  
SELECT 
  'Polygon' as "Chain",
  t.name as "Trader", 
  tr.amount as "Amount USD",
  tr.trade_date as "Date"
FROM polygon.traders t
JOIN polygon.trades tr ON t.id = tr.trader_id
WHERE tr.trade_date >= now() - INTERVAL '7' day

ORDER BY "Amount USD" DESC;
