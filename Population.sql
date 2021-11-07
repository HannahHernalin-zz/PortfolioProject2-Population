--Dataset Link: https://datacatalog.worldbank.org/search/dataset/0037712
--To check the data imported from the 3 datasets are the same.
SELECT *
FROM
    PortfolioProject..Population$

SELECT * 
FROM
    PortfolioProject..TotalFemalePopulation$

SELECT * 
FROM
    PortfolioProject..TotalMalePopulation$

--To check the number of countries in each dataset. As per https://www.worldometers.info/ there are 195 countries in the world.

SELECT COUNT('CountryName')
FROM
    PortfolioProject..Population$
	--PortfolioProject..TotalFemalePopulation$
    --PortfolioProject..TotalMalePopulation$


-- To check total the percentage of female population in every country.
SELECT P.CountryName, P.TotalPopulation2011/F.TotalFemalePopulation2011 AS PercentFemalePopulation2011, P.TotalPopulation2012/F.TotalFemalePopulation2012 AS PercentFemalePopulation2012,
  P.TotalPopulation2013/F.TotalFemalePopulation2013 AS PercentFemalePopulation2013, 
  P.TotalPopulation2014/F.TotalFemalePopulation2014 AS PercentFemalePopulation2014, 
  P.TotalPopulation2015/F.TotalFemalePopulation2015 AS PercentFemalePopulation2015, 
  P.TotalPopulation2016/F.TotalFemalePopulation2016 AS PercentFemalePopulation2016, 
  P.TotalPopulation2017/F.TotalFemalePopulation2017 AS PercentFemalePopulation2017, 
  P.TotalPopulation2018/F.TotalFemalePopulation2018 AS PercentFemalePopulation2018, 
  P.TotalPopulation2019/F.TotalFemalePopulation2019 AS PercentFemalePopulation2019, 
  P.TotalPopulation2020/F.TotalFemalePopulation2020 AS PercentFemalePopulation2020
FROM PortfolioProject..Population$ AS P
JOIN PortfolioProject..TotalFemalePopulation$ AS F 
	ON P.CountryName = F.CountryName
WHERE
  P.CountryName NOT IN ('Africa Eastern and Southern', 'Africa Western and Central', 'Arab World', 'East Asia & Pacific', 'Europe & Central Asia', 'Latin America & Caribbean', 'Middle East & North Africa', 'North America', 'South Asia', 'Sub-Saharan Africa', 'World')

--To calculate the yearly total female population from 2011 to 2020
SELECT SUM(TotalFemalePopulation2011) AS TotalFemalePopulation2011, SUM(TotalFemalePopulation2012) AS TotalFemalePopulation2012, SUM(TotalFemalePopulation2013) AS TotalFemalePopulation2013, SUM(TotalFemalePopulation2014) AS TotalFemalePopulation2014, SUM(TotalFemalePopulation2015) AS TotalFemalePopulation2015, SUM(TotalFemalePopulation2016) AS TotalFemalePopulation2016, SUM(TotalFemalePopulation2017) AS TotalFemalePopulation2017, SUM(TotalFemalePopulation2018) AS TotalFemalePopulation2018, SUM(TotalFemalePopulation2019) AS TotalFemalePopulation2019, SUM(TotalFemalePopulation2020) AS TotalFemalePopulation2020
FROM 
    PortfolioProject..TotalFemalePopulation$
WHERE
  CountryName NOT IN ('Africa Eastern and Southern', 'Africa Western and Central', 'Arab World', 'East Asia & Pacific', 'Europe & Central Asia', 'Latin America & Caribbean', 'Middle East & North Africa', 'North America', 'South Asia', 'Sub-Saharan Africa', 'World')

--To calculate the yearly total male population from 2011 to 2020
SELECT SUM(TotalMalePopulation2011) AS TotalMalePopulation2011, SUM(TotalMalePopulation2012) AS TotalMalePopulation2012, SUM(TotalMalePopulation2013) AS TotalMalePopulation2013, SUM(TotalMalePopulation2014) AS TotalMalePopulation2014, SUM(TotalMalePopulation2015) AS TotalMalePopulation2015, SUM(TotalMalePopulation2016) AS TotalMalePopulation2016, SUM(TotalMalePopulation2017) AS TotalMalePopulation2017, SUM(TotalMalePopulation2018) AS TotalMalePopulation2018, SUM(TotalMalePopulation2019) AS TotalMalePopulation2019, SUM(TotalMalePopulation2020) AS TotalMalePopulation2020
FROM 
    PortfolioProject..TotalMalePopulation$
WHERE
  CountryName NOT IN ('Africa Eastern and Southern', 'Africa Western and Central', 'Arab World', 'East Asia & Pacific', 'Europe & Central Asia', 'Latin America & Caribbean', 'Middle East & North Africa', 'North America', 'South Asia', 'Sub-Saharan Africa', 'World')


-- For Visualization in Tableau.
--1.1 Table 1 - Yearly Total Population in Every Country (2011 - 2020)
SELECT SUM(TotalPopulation2011) AS TotalPopulation2011, SUM(TotalPopulation2012) AS TotalPopulation2012, SUM(TotalPopulation2013) AS TotalPopulation2013, SUM(TotalPopulation2014) AS TotalPopulation2014, SUM(TotalPopulation2015) AS TotalPopulation2015, SUM(TotalPopulation2016) AS TotalPopulation2016, SUM(TotalPopulation2017) AS TotalPopulation2017, SUM(TotalPopulation2018) AS TotalPopulation2018, SUM(TotalPopulation2019) AS TotalPopulation2019, SUM(TotalPopulation2020) AS TotalPopulation2020
FROM 
    PortfolioProject..Population$
WHERE
  CountryName NOT IN ('Africa Eastern and Southern', 'Africa Western and Central', 'Arab World', 'East Asia & Pacific', 'Europe & Central Asia', 'Latin America & Caribbean', 'Middle East & North Africa', 'North America', 'South Asia', 'Sub-Saharan Africa', 'World')


--1.2 Table 1 - Yearly Total Female Population Percentage (2011 - 2020)
--Did not multiply to 100 as the percentage format in tableau automatically formats it to a percentage(x.x%)
--To apply a percentage format to your SQL query use "FORMAT(SUM(F.TotalMalePopulation2011)/SUM(P.TotalPopulation2011, 'P') AS TotalPercentMalePopulation2011" which will yeald a result of 49.56% instead of 0.495597581905219
SELECT SUM(F.TotalFemalePopulation2011)/SUM(P.TotalPopulation2011) AS TotalPercentFemalePopulation2011, 
  SUM(F.TotalFemalePopulation2012)/SUM(P.TotalPopulation2012) AS TotalPercentFemalePopulation2012,
  SUM(F.TotalFemalePopulation2013)/SUM(P.TotalPopulation2013) AS TotalPercentFemalePopulation2013, 
  SUM(F.TotalFemalePopulation2014)/SUM(P.TotalPopulation2014) AS TotalPercentFemalePopulation2014, 
  SUM(F.TotalFemalePopulation2015)/SUM(P.TotalPopulation2015) AS TotalPercentFemalePopulation2015, 
  SUM(F.TotalFemalePopulation2016)/SUM(P.TotalPopulation2016) AS TotalPercentFemalePopulation2016, 
  SUM(F.TotalFemalePopulation2017)/SUM(P.TotalPopulation2017) AS TotalPercentFemalePopulation2017, 
  SUM(F.TotalFemalePopulation2018)/SUM(P.TotalPopulation2018) AS TotalPercentFemalePopulation2018, 
  SUM(F.TotalFemalePopulation2019)/SUM(P.TotalPopulation2019) AS TotalPercentFemalePopulation2019, 
  SUM(F.TotalFemalePopulation2020)/SUM(P.TotalPopulation2020) AS TotalPercentFemalePopulation2020
FROM PortfolioProject..Population$ AS P
JOIN PortfolioProject..TotalFemalePopulation$ AS F 
	ON P.CountryName = F.CountryName
WHERE
  P.CountryName NOT IN ('Africa Eastern and Southern', 'Africa Western and Central', 'Arab World', 'East Asia & Pacific', 'Europe & Central Asia', 'Latin America & Caribbean', 'Middle East & North Africa', 'North America', 'South Asia', 'Sub-Saharan Africa', 'World')

--1.3 Table 1 - Yearly Total Male Population Percentage (2011 - 2020)
--Did not multiply to 100 as the percentage format in tableau automatically formats it to a percentage(x.x%)
--To apply a percentage format to your query in SQL use "FORMAT(SUM(F.TotalMalePopulation2011)/SUM(P.TotalPopulation2011, 'P') AS TotalPercentMalePopulation2011" which will yeald a result of 50.40% instead of 0.504003827635905

SELECT SUM(F.TotalMalePopulation2011)/SUM(P.TotalPopulation2011) AS TotalPercentMalePopulation2011, 
  SUM(F.TotalMalePopulation2012)/SUM(P.TotalPopulation2012) AS TotalPercentMalePopulation2012,
  SUM(F.TotalMalePopulation2013)/SUM(P.TotalPopulation2013) AS TotalPercentMalePopulation2013, 
  SUM(F.TotalMalePopulation2014)/SUM(P.TotalPopulation2014) AS TotalPercentMalePopulation2014, 
  SUM(F.TotalMalePopulation2015)/SUM(P.TotalPopulation2015) AS TotalPercentMalePopulation2015, 
  SUM(F.TotalMalePopulation2016)/SUM(P.TotalPopulation2016) AS TotalPercentMalePopulation2016, 
  SUM(F.TotalMalePopulation2017)/SUM(P.TotalPopulation2017) AS TotalPercentMalePopulation2017, 
  SUM(F.TotalMalePopulation2018)/SUM(P.TotalPopulation2018) AS TotalPercentMalePopulation2018, 
  SUM(F.TotalMalePopulation2019)/SUM(P.TotalPopulation2019) AS TotalPercentMalePopulation2019, 
  SUM(F.TotalMalePopulation2020)/SUM(P.TotalPopulation2020) AS TotalPercentMalePopulation2020
FROM PortfolioProject..Population$ AS P
JOIN PortfolioProject..TotalMalePopulation$ AS F 
	ON P.CountryName = F.CountryName
WHERE
  P.CountryName NOT IN ('Africa Eastern and Southern', 'Africa Western and Central', 'Arab World', 'East Asia & Pacific', 'Europe & Central Asia', 'Latin America & Caribbean', 'Middle East & North Africa', 'North America', 'South Asia', 'Sub-Saharan Africa', 'World')


--2.1 Table 2 - Yearly Female Population Percentage in Every Country (2011 - 2020)
SELECT P.CountryName, P.TotalPopulation2011/F.TotalFemalePopulation2011 AS PercentFemalePopulation2011, P.TotalPopulation2012/F.TotalFemalePopulation2012 AS PercentFemalePopulation2012,
  P.TotalPopulation2013/F.TotalFemalePopulation2013 AS PercentFemalePopulation2013, 
  P.TotalPopulation2014/F.TotalFemalePopulation2014 AS PercentFemalePopulation2014, 
  P.TotalPopulation2015/F.TotalFemalePopulation2015 AS PercentFemalePopulation2015, 
  P.TotalPopulation2016/F.TotalFemalePopulation2016 AS PercentFemalePopulation2016, 
  P.TotalPopulation2017/F.TotalFemalePopulation2017 AS PercentFemalePopulation2017, 
  P.TotalPopulation2018/F.TotalFemalePopulation2018 AS PercentFemalePopulation2018, 
  P.TotalPopulation2019/F.TotalFemalePopulation2019 AS PercentFemalePopulation2019, 
  P.TotalPopulation2020/F.TotalFemalePopulation2020 AS PercentFemalePopulation2020
FROM PortfolioProject..Population$ AS P
JOIN PortfolioProject..TotalFemalePopulation$ AS F 
	ON P.CountryName = F.CountryName
WHERE
  P.CountryName NOT IN ('Africa Eastern and Southern', 'Africa Western and Central', 'Arab World', 'East Asia & Pacific', 'Europe & Central Asia', 'Latin America & Caribbean', 'Middle East & North Africa', 'North America', 'South Asia', 'Sub-Saharan Africa', 'World')

