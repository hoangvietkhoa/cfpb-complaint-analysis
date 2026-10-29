-- CFPB Complaint Analysis, 2025
-- 5 banks: Capital One, JPMorgan Chase, Wells Fargo, Bank of America, American Express
-- Author: Khoa Hoang
-- Q1: Which companies get the most complaints?

SELECT Company,
count(*) AS complaints, 
round(count(*)*100.0/(SELECT count(*) FROM complaints),2) AS pct_of_total
From complaints
GROUP By Company
ORDER BY complaints DESC;

-- Q2a: Which products drive complaints?

SELECT Product,
count(*) AS complaints, 
round(count(*)*100.0/(SELECT count(*) FROM complaints),2) AS pct_of_total
From complaints
GROUP By Product
ORDER BY complaints DESC;

-- Q2b: Product mix for Wells Fargo

SELECT Product,
       COUNT(*) AS complaints,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM complaints
                                 WHERE Company = "WELLS FARGO & COMPANY"), 2) AS pct_of_bank
FROM complaints
WHERE Company = "WELLS FARGO & COMPANY"
GROUP BY Product
ORDER BY complaints DESC;

--Q2c: Product mix for American Express

SELECT Product,
       COUNT(*) AS complaints,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM complaints
                                 WHERE Company = "AMERICAN EXPRESS COMPANY"), 2) AS pct_of_bank
FROM complaints
WHERE Company = "AMERICAN EXPRESS COMPANY"
GROUP BY Product
ORDER BY complaints DESC;

-- Q2d: Top 10 complaint issues (all 5 banks)

SELECT Issue,
count(*) AS complaints, 
round(count(*)*100.0/(SELECT count(*) FROM complaints),2) AS pct_of_total
From complaints
GROUP By Issue
ORDER BY complaints DESC
LIMIT 10;

-- Q3a: On-time vs late responses by company

SELECT Company,
       "Timely response?" AS timely,
       COUNT(*) AS complaints
FROM complaints
GROUP BY Company, "Timely response?"
ORDER BY Company;

-- Q3b: Late response rate by company

SELECT Company,
       COUNT(*) AS complaints,
       SUM(CASE WHEN "Timely response?" = 'No' THEN 1 ELSE 0 END) AS late,
       ROUND(SUM(CASE WHEN "Timely response?" = 'No' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS late_pct
FROM complaints
GROUP BY Company
ORDER BY late_pct DESC;