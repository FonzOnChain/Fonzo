-- =====================================================
-- DAY 13: WINDOW FUNCTIONS Practice
-- Author: Fonzo | FAAAAAA Mode ON
-- =====================================================
-- Table: transactions
-- Columns: wallet, amount_usd, block_date
-- =====================================================

-- Q1: TOP 5 WALLETS WITH RANK
-- Window Function: RANK()
-- Kaam: Har wallet ka total nikalo + ranking do

WITH wallet_volume AS (
  SELECT 
    wallet,
    COUNT(*) as tx_count,
    SUM(amount_usd) as total_volume
  FROM transactions
  GROUP BY wallet
)
SELECT 
  wallet,
  tx_count,
  ROUND(total_volume, 2) as total_usd,
  RANK() OVER (ORDER BY total_volume DESC) as rank
FROM wallet_volume
ORDER BY rank
LIMIT 5;

-- Q2: DAILY GROWTH REPORT  
-- Window Function: LAG()
-- Kaam: Har din ka volume + pichle din se growth

WITH daily_volume AS (
  SELECT 
    block_date,
    SUM(amount_usd) as day_volume
  FROM transactions
  GROUP BY block_date
)
SELECT 
  block_date,
  ROUND(day_volume, 2) as today_usd,
  ROUND(LAG(day_volume) OVER (ORDER BY block_date), 2) as prev_day_usd,
  ROUND(day_volume - LAG(day_volume) OVER (ORDER BY block_date), 2) as growth_usd,
  ROUND(
    (day_volume - LAG(day_volume) OVER (ORDER BY block_date)) 
    / LAG(day_volume) OVER (ORDER BY block_date) * 100, 
    2
  ) as growth_percent
FROM daily_volume
ORDER BY block_date DESC
LIMIT 30;

-- Q3 BONUS: RUNNING TOTAL FOR EACH WALLET
-- Window Function: SUM() OVER PARTITION
-- Kaam: Har wallet ka cumulative volume

SELECT 
  wallet,
  block_date,
  ROUND(amount_usd, 2) as tx_amount,
  ROUND(
    SUM(amount_usd) OVER (PARTITION BY wallet ORDER BY block_date), 
    2
  ) as running_total
FROM transactions
ORDER BY wallet, block_date;
