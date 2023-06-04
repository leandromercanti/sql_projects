-- S&P 500 Index - Data Analysis Project (Data collected from Datahub.io):

-- 1: S&P 500 Level: Calculate the average, max and min levels of the S&P 500 index over the entire dataset.
SELECT MIN(SP500) AS Min_Level, ROUND(AVG(SP500),2) AS Average_Level, MAX(SP500) AS Max_Level
FROM sp500_index_csv;


-- 2: Yearly Average Dividend and Earnings: Calculate the average dividend and earnings on a yearly basis.
SELECT YEAR(Date) AS Year, ROUND(AVG(Dividend),2) AS Avg_Dividend, ROUND(AVG(Earnings),2) AS Avg_Earnings
FROM sp500_index_csv
GROUP BY Year
ORDER BY Year DESC;


-- 3: Top 10 Highest PE10 Values: Retrieve the top 10 highest PE10 values along with the corresponding dates.
SELECT Date, PE10
FROM sp500_index_csv
ORDER BY PE10 DESC
LIMIT 10;


-- 4: Yearly Change: Calculate the annual change in the S&P 500 index.
SELECT YEAR(Date) AS Year, ROUND(MAX(SP500) - MIN(SP500),2) AS Yearly_Change
FROM sp500_index_csv
GROUP BY YEAR(Date)
ORDER BY YEAR(Date) DESC;


-- 5: Top 10 Monthly Returns: Retrieve the top 10 months with the highest returns of the S&P 500 index.
SELECT Date, SP500,
       ROUND((SP500 / LAG(SP500) OVER (ORDER BY Date)) - 1,2) AS Monthly_Return
FROM sp500_index_csv
ORDER BY Monthly_Return DESC
LIMIT 10;

