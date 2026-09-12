-- =====================================================
-- DAY 12: CTE - Common Table Expression Practice
-- Author: Fonzo | FAAAAAA Mode ON
-- =====================================================

-- Maan lo table ka naam: transactions
-- Columns: wallet, amount_usd, block_date

-- Q1: Top Wallets with $100k+ using CTE
-- Step 1: Pehle $1000 se badi tx filter karo
-- Step 2: Phir har wallet ka total nikalo
-- Step 3: Final mein $100k+ wale dikhao

WITH big_transactions AS (
  SELECT 
    wallet,
    amount_usd
  FROM transactions
  WHERE amount_usd > 1000
),

wallet_totals AS (
  SELECT 
    wallet,
    COUNT(*) as tx_count,
    SUM(amount_usd) as total_usd
  FROM big_transactions
  GROUP BY wallet
)

SELECT 
  wallet,
  tx_count,
  ROUND(total_usd, 2) as total_usd
FROM wallet_totals
WHERE total_usd > 100000
ORDER BY total_usd DESC
LIMIT 10;

-- Q2: 3+ Din Active Rehne Wale Wallets using Double CTE
-- Step 1: Roz ka data banao
-- Step 2: Usme se streak count karo

WITH daily_activity AS (
  SELECT 
    wallet,
    block_date,
    COUNT(*) as txs_that_day
  FROM transactions
  GROUP BY wallet, block_date
),

active_days AS (
  SELECT 
    wallet,
    COUNT(DISTINCT block_date) as active_day_count
  FROM daily_activity
  GROUP BY wallet
)

SELECT 
  wallet,
  active_day_count
FROM active_days
WHERE active_day_count >= 3
ORDER BY active_day_count DESC;
