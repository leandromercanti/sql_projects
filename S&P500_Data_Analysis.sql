-- S&P 500 Companies and Sectors - Data Analysis Project (Data collected from Datahub.io):

-- 1: Check how the dataset is looking like:
SELECT * FROM stock_market.constituents_financials_csv;

-- 2: Top 10 companies by Market Cap:
SELECT Symbol, Name, `Market Cap`
FROM constituents_financials_csv
ORDER BY `Market Cap` DESC
LIMIT 10;

-- 3: Average price/earnings ratio for each sector:
SELECT Sector, ROUND(AVG(`Price/Earnings`),2) AS AvgPE
FROM constituents_financials_csv
GROUP BY Sector
ORDER BY AvgPE;

-- 4: Identify stocks with a dividend yield greater than 5%:
SELECT Symbol, Name, ROUND(`Dividend Yield`,2)
FROM constituents_financials_csv
WHERE `Dividend Yield` > 5
ORDER BY `Dividend Yield` DESC;

-- 5: Top 20 stocks with the highest earnings per share (EPS):
SELECT Symbol, Name, `Earnings/Share`
FROM constituents_financials_csv
ORDER BY `Earnings/Share` DESC
LIMIT 20;

-- 6: Top 5 sectors with the highest average dividend yield:
SELECT Sector, ROUND(AVG(`Dividend Yield`),2) AS AvgDividendYield
FROM constituents_financials_csv
GROUP BY Sector
ORDER BY AvgDividendYield DESC
LIMIT 5;

-- 7: Stocks with a price-to-earnings (P/E) ratio below the sector average:
SELECT Symbol, Name, `Price/Earnings`, Sector
FROM constituents_financials_csv c1
WHERE `Price/Earnings` < (
    SELECT AVG(`Price/Earnings`)
    FROM constituents_financials_csv c2
    WHERE c1.Sector = c2.Sector
)
ORDER BY `Price/Earnings`;

-- 8: Percentage change in price from the 52-week low to the current price for each stock:
SELECT Symbol, Name, Price, `52 Week Low`,
       ROUND(((Price - `52 Week Low`) / `52 Week Low`),3) * 100 AS PriceChangePercentage
FROM constituents_financials_csv
ORDER BY PriceChangePercentage DESC;

-- 9: Sectors with the highest number of stocks trading below their 52-week low:
SELECT Sector, COUNT(*) AS NumStocksAbove52WeekLow
FROM constituents_financials_csv
WHERE Price < `52 Week Low`
GROUP BY Sector
ORDER BY NumStocksAbove52WeekLow DESC;

