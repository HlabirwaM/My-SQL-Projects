-- Creating the 'bank' Table in the campaign database
CREATE TABLE bank (
    age SMALLINT,
    job VARCHAR(30),
    marital VARCHAR(30),
    education VARCHAR(30),
    "default" VARCHAR(4),
    balance INT,
    housing VARCHAR(4),
    loan VARCHAR(4),
    contact VARCHAR(15),
    "day" SMALLINT,
    "month" VARCHAR(15),
    duration SMALLINT,
    campaign SMALLINT,
    pdays SMALLINT,
    previous SMALLINT,
    poutcome SMALLINT,
    y VARCHAR(4)
);

-- Load the 'bank' table
SELECT * FROM bank;

--- Demographic Analysis ---

-- Age Distribution Analysis
SELECT 
    MIN(age) AS "Minimum Age",
    MAX(age) AS "Maximum Age",
    ROUND(AVG(age), 0) AS "Average Age"
FROM bank;

-- Age Group Categorization and Analysis
SELECT 
    CASE  
        WHEN age <= 30 THEN 'Under 30'
        WHEN age > 30 AND age <= 40 THEN 'Between 30-40'
        WHEN age > 40 AND age <= 50 THEN 'Between 40-50'
        WHEN age > 50 AND age <= 70 THEN 'Between 50-70'
        ELSE 'Above 70'
    END AS "Age Group",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS "Percentage"
FROM bank
GROUP BY "Age Group"
ORDER BY "Percentage" DESC;

-- Marital Status Analysis
SELECT 
    Marital AS "Marital Status",
    COUNT(*) AS "Number of Clients",
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), 1) AS "Percentage"
FROM bank
GROUP BY marital
ORDER BY COUNT(*) DESC;

-- Job Title Analysis
SELECT 
    job AS "Job Title",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS "Percentage"
FROM bank
GROUP BY "Job Title"
ORDER BY COUNT(*) DESC;

-- Marital Status per Age Group Analysis
SELECT 
    marital AS "Marital Status",
    CASE  
        WHEN age <= 30 THEN 'Under 30'
        WHEN age > 30 AND age <= 40 THEN 'Between 30-40'
        WHEN age > 40 AND age <= 50 THEN 'Between 40-50'
        WHEN age > 50 AND age <= 70 THEN 'Between 50-70'
        ELSE 'Above 70'
    END AS "Age Group",
    COUNT(*) AS "Number of Clients",
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), 1) AS "Percentage"
FROM bank
GROUP BY "Marital Status", "Age Group"
ORDER BY COUNT(*) DESC;

-- Education Level Analysis
SELECT 
    education AS "Education Level",
    COUNT(*) AS "Number of Clients",
    ROUND((COUNT(*) * 100 / SUM(COUNT(*)) OVER ()), 1) AS "Percentage"
FROM bank
GROUP BY "Education Level"
ORDER BY COUNT(*) DESC;

-- Full Demographic Analysis Summary
SELECT 
    marital AS "Marital Status",
    education AS "Education Level",
    CASE  
        WHEN age <= 30 THEN 'Under 30'
        WHEN age > 30 AND age <= 40 THEN 'Between 30-40'
        WHEN age > 40 AND age <= 50 THEN 'Between 40-50'
        WHEN age > 50 AND age <= 70 THEN 'Between 50-70'
        ELSE 'Above 70'
    END AS "Age Group",
    COUNT(*) AS "Number of Clients",
    ROUND((COUNT(*) * 100 / SUM(COUNT(*)) OVER ()), 2) AS "Percentage"
FROM bank
GROUP BY "Marital Status", "Age Group", "Education Level"
ORDER BY COUNT(*) DESC;

--- Financial Analysis ---

-- Default Behavior Analysis
SELECT 
    "default" AS "Default",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS "Percentage"
FROM bank
GROUP BY "Default"
ORDER BY COUNT(*) DESC;

-- Housing Loan Analysis
SELECT 
    housing AS "Housing",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS "Percentage"
FROM bank
GROUP BY "Housing"
ORDER BY COUNT(*) DESC;

-- Existing Loan Analysis
SELECT 
    loan AS "Has Loan(Yes/No)",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS "Percentage"
FROM bank
GROUP BY "Has Loan(Yes/No)"
ORDER BY COUNT(*) DESC;

-- Marital Status vs. Housing Loan Analysis
SELECT 
    marital AS "Marital Status",
    housing AS "Housing",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS "Percentage"
FROM bank
GROUP BY "Marital Status", "Housing"
ORDER BY COUNT(*) DESC;

-- Education Level vs. Housing Loan Analysis
SELECT 
    education AS "Education Level",
    housing AS "Housing",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS "Percentage"
FROM bank
GROUP BY "Education Level", "Housing"
ORDER BY COUNT(*) DESC;

-- Marital Status vs. Loan Status Analysis
SELECT 
    marital AS "Marital Status",
    loan AS "Has Loan(Yes/No)",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS "Percentage"
FROM bank
GROUP BY "Marital Status", "Has Loan(Yes/No)"
ORDER BY COUNT(*) DESC;

-- Education Level vs. Loan Status Analysis
SELECT 
    education AS "Education Level",
    loan AS "Has Loan(Yes/No)",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS "Percentage"
FROM bank
GROUP BY "Education Level", "Has Loan(Yes/No)"
ORDER BY COUNT(*) DESC;

--- Campaign Outcome Analysis ---

-- Positive Outcome Analysis
SELECT 
    y AS "Outcome",
    COUNT(*) AS "Number of Clients",
    ROUND((COUNT(*) * 100 / SUM(COUNT(*)) OVER ()), 1) AS "Percentage"
FROM bank
GROUP BY "Outcome"
ORDER BY "Outcome" DESC;

-- Communication Method vs. Outcome Analysis
SELECT 
    contact AS "Communication Method",
    y AS "Outcome",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS "Percentage"
FROM bank
GROUP BY "Communication Method", "Outcome"
ORDER BY "Outcome" DESC, COUNT(*) DESC;

-- Number of Contacts vs. Outcome Analysis
SELECT 
    campaign AS "Number of Contacts",
    y AS "Outcome",
    COUNT(*) AS "Number of Clients",
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 3) AS "Percentage"
FROM bank
GROUP BY "Number of Contacts", "Outcome"
ORDER BY "Outcome" DESC, COUNT(*) DESC;

-- Demographic Analysis vs. Outcome Analysis

SELECT 
    marital AS "Marital Status",
    y AS "Outcome",
    COUNT(*) AS "Number of Clients",
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), 1) AS "Percentage"
FROM bank
GROUP BY "Marital Status", "Outcome"
ORDER BY "Outcome" DESC;

SELECT 
    education AS "Education Level",
    y AS "Outcome",
    COUNT(*) AS "Number of Clients",
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), 1) AS "Percentage"
FROM bank
GROUP BY "Education Level", "Outcome"
ORDER BY "Outcome" DESC, "Percentage" DESC;

SELECT 
    job AS "Job Title",
    y AS "Outcome",
    COUNT(*) AS "Number of Clients",
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), 1) AS "Percentage"
FROM bank
GROUP BY "Job Title", "Outcome"
ORDER BY "Outcome" DESC, "Percentage" DESC;

SELECT 
    CASE  
        WHEN age <= 30 THEN 'Under 30'
        WHEN age > 30 AND age <= 40 THEN 'Between 30-40'
        WHEN age > 40 AND age <= 50 THEN 'Between 40-50'
        WHEN age > 50 AND age <= 70 THEN 'Between 50-70'
        ELSE 'Above 70'
    END AS "Age Group",
    y AS "Outcome",
    COUNT(*) AS "Number of Clients",
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), 1) AS "Percentage"
FROM bank
GROUP BY "Age Group", "Outcome"
ORDER BY "Outcome" DESC, "Percentage" DESC;

-- end
