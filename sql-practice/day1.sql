    -- Day 1: COUNT and GROUP BY practice
    -- Goal: Count transactions per blockchain for today

    SELECT 
        blockchain, 
        COUNT(*) as total_transactions
    FROM ethereum.transactions
    WHERE date = CURRENT_DATE
    GROUP BY blockchain
    ORDER BY total_transactions DESC;
