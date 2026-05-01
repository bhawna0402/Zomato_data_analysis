-- ═══════════════════════════════════════════════
-- ZOMATO RESTAURANT ANALYSIS — SQL QUERIES (2018)
-- ═══════════════════════════════════════════════
-- Note: Written in SQL Server syntax for documentation
-- Notebook uses SQLite-compatible syntax (see zomato_eda.ipynb)

-- QUERY 1: Top Indian cities by average rating
-- Business question: Which cities have the best dining quality?
-- ───────────────────────────────────────────────
SELECT 
    City,
    COUNT(*) AS total_restaurants,
    ROUND(AVG([Aggregate rating]), 2) AS avg_rating,
    ROUND(AVG([Average Cost for two]), 0) AS avg_cost_inr
FROM zomato
WHERE [Aggregate rating] > 0
  AND Country = 'India'
GROUP BY City
HAVING COUNT(*) > 20
ORDER BY avg_rating DESC;


-- QUERY 2: Online delivery impact on ratings
-- Business question: Do delivery restaurants rate higher?
-- ───────────────────────────────────────────────
SELECT 
    [Has Online delivery],
    COUNT(*) AS restaurant_count,
    ROUND(AVG([Aggregate rating]), 2) AS avg_rating,
    ROUND(AVG([Average Cost for two]), 0) AS avg_cost,
    ROUND(AVG(Votes), 0) AS avg_votes
FROM zomato
WHERE [Aggregate rating] > 0
  AND Country = 'India'
GROUP BY [Has Online delivery];


-- QUERY 3: Top cuisines by rating (WITH WINDOW FUNCTION)
-- Business question: Which cuisines dominate quality dining?
-- ───────────────────────────────────────────────
SELECT 
    Cuisines,
    COUNT(*) AS restaurant_count,
    ROUND(AVG([Aggregate rating]), 2) AS avg_rating,
    RANK() OVER (ORDER BY AVG([Aggregate rating]) DESC) AS rating_rank
FROM zomato
WHERE [Aggregate rating] > 0
  AND Country = 'India'
  AND Cuisines IS NOT NULL
GROUP BY Cuisines
HAVING COUNT(*) > 20
ORDER BY avg_rating DESC;


-- QUERY 4: Value score — best rating per rupee spent
-- Business question: Where do you get best quality for money?
-- SQLite equivalent: replace SELECT TOP 15 with SELECT ... LIMIT 15
-- ───────────────────────────────────────────────
SELECT TOP 15
    [Restaurant Name],
    City,
    Cuisines,
    [Aggregate rating],
    [Average Cost for two],
    ROUND(
        CAST([Aggregate rating] AS FLOAT) / 
        NULLIF([Average Cost for two], 0) * 100, 3
    ) AS value_score
FROM zomato
WHERE [Aggregate rating] > 0
  AND Country = 'India'
  AND [Average Cost for two] > 0
ORDER BY value_score DESC;


-- QUERY 5: City expansion score (composite metric)
-- Business question: Which cities should Zomato expand in?
-- ───────────────────────────────────────────────
SELECT 
    City,
    COUNT(*) AS total_restaurants,
    ROUND(AVG([Aggregate rating]), 2) AS avg_rating,
    ROUND(AVG([Average Cost for two]), 0) AS avg_cost,
    SUM(CASE WHEN [Has Online delivery] = 'Yes' THEN 1 ELSE 0 END) AS delivery_enabled,
    ROUND(
        100.0 * SUM(CASE WHEN [Has Online delivery] = 'Yes' THEN 1 ELSE 0 END) 
        / COUNT(*), 1
    ) AS delivery_adoption_pct,
    ROUND(
        AVG([Aggregate rating]) * 
        (100.0 * SUM(CASE WHEN [Has Online delivery] = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) 
        / 100, 3
    ) AS expansion_score
FROM zomato
WHERE [Aggregate rating] > 0
  AND Country = 'India'
GROUP BY City
HAVING COUNT(*) > 20
ORDER BY expansion_score DESC;
