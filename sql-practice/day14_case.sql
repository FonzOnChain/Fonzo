-- =====================================================
-- DAY 14: CASE WHEN + ADVANCED AGGREGATION
-- Author: Fonzo | FAAAAAA Mode ON
-- =====================================================

-- Q1: WALLET SEGMENTATION
WITH wallet_stats AS (
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
  CASE 
    WHEN total_volume > 50000 THEN 'Whale 🐋'
    WHEN total_volume > 10000 THEN 'Dolphin 🐬'
    ELSE 'Retail 🐟'
  END as segment,
  RANK() OVER (ORDER BY total_volume DESC) as rank
FROM wallet_stats
ORDER BY total_volume DESC
LIMIT 20;


-- Q2: DAILY VOLUME BREAKDOWN
SELECT 
  block_date,
  ROUND(SUM(amount_usd), 2) as total_volume,
  ROUND(SUM(CASE WHEN amount_usd > 10000 THEN amount_usd ELSE 0 END), 2) as whale_volume,
  ROUND(SUM(CASE WHEN amount_usd BETWEEN 1000 AND 10000 THEN amount_usd ELSE 0 END), 2) as dolphin_volume,
  ROUND(SUM(CASE WHEN amount_usd < 1000 THEN amount_usd ELSE 0 END), 2) as retail_volume
FROM transactions
GROUP BY block_date
ORDER BY block_date DESC
LIMIT 30;
