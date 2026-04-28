-- Startup Funding Analysis: BigQuery SQL Analysis Layer
-- SQL Engine: BigQuery Standard SQL
-- Dataset: startup_funding
-- Table: startup_data
-- Rows analyzed: 1,576
--
-- Note:
-- These queries are designed for portfolio-level business analysis.
-- They support the Tableau dashboard and README findings by analyzing
-- funding concentration, geography, year-over-year trends, hiring signals,
-- trend signals, and industry-level company rankings.

-- Query 1: Funding by industry
-- Business question:
-- Which industries receive the most funding in the analyzed startup dataset?
-- What this query shows:
-- Aggregates company count, total funding, and average funding by cleaned industry category.
SELECT
    Industry_Category,
    COUNT(Organization_Name) AS company_count,
    SUM(Total_Funding_Amount) AS total_funding,
    ROUND(AVG(Total_Funding_Amount), 2) AS avg_funding
FROM 
    `startups-sql-data-portfolio.startup_funding.startup_data`
WHERE 
    Total_Funding_Amount IS NOT NULL
GROUP BY 
    Industry_Category
ORDER BY 
    total_funding DESC;

-- Query 2: Startup concentration and funding by region
-- Business question:
-- Which regions have the highest startup concentration and funding activity?
-- What this query shows:
-- Compares startup count, total funding, and average funding by headquarters state/region.
SELECT
    State AS headquarters_region,
    COUNT(Organization_Name) AS startup_count,
    SUM(Total_Funding_Amount) AS total_funding,
    ROUND(AVG(Total_Funding_Amount), 2) AS avg_funding
FROM 
    `startups-sql-data-portfolio.startup_funding.startup_data`
WHERE 
    State IS NOT NULL
GROUP BY 
    State
ORDER BY 
    startup_count DESC;

-- Query 3: Funding trend by year
-- Business question:
-- How did funding activity change between 2024 and 2025 within the analyzed dataset?
-- What this query shows:
-- Compares deal count, total funding, and average deal size by last funding year.
SELECT
    Last_Funding_Year AS funding_year,
    COUNT(Organization_Name) AS deal_count,
    SUM(Total_Funding_Amount) AS total_funding,
    ROUND(AVG(Total_Funding_Amount), 2) AS avg_deal_size
FROM 
    `startups-sql-data-portfolio.startup_funding.startup_data`
WHERE 
    Last_Funding_Year IS NOT NULL
GROUP BY 
    Last_Funding_Year
ORDER BY 
    funding_year;

-- Query 4: Active hiring rate by industry
-- Business question:
-- Which industries show the strongest active hiring signals?
-- What this query shows:
-- Calculates the percentage of companies marked as actively hiring within each industry.
SELECT
    Industry_Category,
    COUNT(Organization_Name) AS company_count,
    SUM(CASE WHEN Active_Hiring = TRUE THEN 1 ELSE 0 END) AS active_hiring_count,
    ROUND(
        SUM(CASE WHEN Active_Hiring = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(Organization_Name),
        2
    ) AS active_hiring_rate
FROM 
    `startups-sql-data-portfolio.startup_funding.startup_data`
GROUP BY 
    Industry_Category
HAVING 
    COUNT(Organization_Name) >= 10
ORDER BY 
    active_hiring_rate DESC;

-- Query 5: High-trend companies with relatively low funding
-- Business question:
-- Which lower-funded startups show strong recent trend signals?
-- What this query shows:
-- Identifies companies with less than $10M in total funding and strong 30-day trend scores.
SELECT
    Organization_Name AS company_name,
    Industry_Category,
    State AS headquarters_region,
    Total_Funding_Amount,
    Trend_Score_30_Days,
    Active_Hiring
FROM 
    `startups-sql-data-portfolio.startup_funding.startup_data`
WHERE 
    Total_Funding_Amount < 10000000
    AND Trend_Score_30_Days >= 8.0
ORDER BY 
    Trend_Score_30_Days DESC,
    Total_Funding_Amount ASC
LIMIT 15;

-- Query 6: Top-funded companies within each industry
-- Business question:
-- Which companies rank highest in funding within each industry?
-- What this query shows:
-- Uses a window function to rank companies by total funding inside each industry category.
WITH ranked_companies AS (
    SELECT
        Organization_Name AS company_name,
        Industry_Category,
        Total_Funding_Amount,
        RANK() OVER (
            PARTITION BY Industry_Category
            ORDER BY Total_Funding_Amount DESC
        ) AS funding_rank
    FROM 
        `startups-sql-data-portfolio.startup_funding.startup_data`
    WHERE 
        Total_Funding_Amount IS NOT NULL
)
SELECT
    company_name,
    Industry_Category,
    Total_Funding_Amount,
    funding_rank
FROM 
    ranked_companies
WHERE 
    funding_rank <= 5
ORDER BY 
    Industry_Category, 
    funding_rank;
