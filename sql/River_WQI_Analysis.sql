USE river_water_quality;

SELECT COUNT(*) AS total_rows
FROM river_wqi;
------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM river_wqi
LIMIT 5;

-------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE river_wqi
RENAME COLUMN `Electric Conductivity (ÃŽÂ¼S/cm)` TO `EC (uS/cm)`;
ALTER TABLE river_wqi
RENAME COLUMN `Temperature (Ã‚ÂºC)` TO `Temp (°C)`;
ALTER TABLE river_wqi
RENAME COLUMN `Carbonate (mg/L)` TO `CO3 (mg/L)`;
ALTER TABLE river_wqi
RENAME COLUMN `Calcium (mg/L)` TO `Ca (mg/L)`;
ALTER TABLE river_wqi
RENAME COLUMN `Chloride (mg/L)` TO `Cl (mg/L)`;
ALTER TABLE river_wqi
RENAME COLUMN `Dissolved oxygen (mg/L)` TO `DO (mg/L)`;
ALTER TABLE river_wqi
RENAME COLUMN `Bicarbonate (mg/L)` TO `HCO3 (mg/L)`;
ALTER TABLE river_wqi
RENAME COLUMN `Magnesium (mg/L)` TO `Mg (mg/L)`;
ALTER TABLE river_wqi
RENAME COLUMN `Sodium (mg/L)` TO `Na (mg/L)`;
ALTER TABLE river_wqi
RENAME COLUMN `Potential of Hydrogen (pH)` TO `pH`;
ALTER TABLE river_wqi
RENAME COLUMN `Sulphate (mg/L)` TO `SO4 (mg/L)`;
ALTER TABLE river_wqi
RENAME COLUMN `Total Alkalinity (mg/L as CaCO3)` TO `TA (mg/L as CaCO3)`;
ALTER TABLE river_wqi
RENAME COLUMN `Total Hardness (mgCaCO3/L)` TO `TH (mg/L as CaCO3)`;
ALTER TABLE river_wqi
RENAME COLUMN `Nitrate N (mgN/L)` TO `NO3-N (mgN/L)`;
ALTER TABLE river_wqi
RENAME COLUMN `Sodium Adsorption Ratio (%)` TO `SAR (%)`;
ALTER TABLE river_wqi
RENAME COLUMN `Biochemical Oxygen Demand (mg/L)` TO `BOD (mg/L)`;

----------------------------------------------------------------------------------------------------------------------------------

SELECT COUNT(*) AS Total_Observations
FROM river_wqi;

SELECT COUNT(DISTINCT River) AS Total_Rivers
FROM river_wqi;

SELECT DISTINCT River AS Total_Rivers
FROM river_wqi;

SELECT COUNT(DISTINCT Station) AS Total_Stations
FROM river_wqi;

SELECT DISTINCT YEAR(`Data Acquisition Time`) AS Year
FROM river_wqi
ORDER BY Year;

SELECT `Data Acquisition Time`
FROM river_wqi
LIMIT 10;

SELECT COUNT(*) AS Total_Rows
FROM river_wqi;

SELECT
    River,
    ROUND(AVG(WQI),2) AS Avg_WQI
FROM river_wqi
GROUP BY River
ORDER BY Avg_WQI DESC;

SELECT
    River,
    MAX(WQI) AS Max_WQI
FROM river_wqi
GROUP BY River
ORDER BY Max_WQI DESC;

SELECT
    River,
    MIN(WQI) AS Min_WQI
FROM river_wqi
GROUP BY River
ORDER BY Min_WQI;

SELECT
    River,
    COUNT(DISTINCT Station) AS Stations
FROM river_wqi
GROUP BY River
ORDER BY Stations DESC;

SELECT
    River,
    COUNT(*) AS Samples
FROM river_wqi
GROUP BY River;

SELECT
    Station,
    River,
    AVG(WQI) AS Avg_WQI
FROM river_wqi
GROUP BY Station,River
ORDER BY Avg_WQI DESC
LIMIT 10;

SELECT
    Station,
    River,
    AVG(WQI) AS Avg_WQI
FROM river_wqi
GROUP BY Station,River
ORDER BY Avg_WQI
LIMIT 10;

SELECT
    Station,
    COUNT(*) AS Samples
FROM river_wqi
GROUP BY Station
ORDER BY Samples DESC;

SELECT
    State,
    AVG(WQI) AS Avg_WQI
FROM river_wqi
GROUP BY State;

SELECT
    YEAR(`Data Acquisition Time`) AS Year,
    MONTH(`Data Acquisition Time`) AS Month,
    AVG(WQI) AS Avg_WQI
FROM river_wqi
GROUP BY Year,Month
ORDER BY Year,Month;

SELECT
    River,
    YEAR(`Data Acquisition Time`) AS Year,
    MONTH(`Data Acquisition Time`) AS Month,
    AVG(WQI) AS Avg_WQI
FROM river_wqi
GROUP BY River,Year,Month
ORDER BY River,Year,Month;

SELECT
    River,
    AVG(`Dissolved oxygen (mg/L)`) AS Avg_DO
FROM river_wqi
GROUP BY River;

SELECT
    River,
    AVG(`Biochemical Oxygen Demand (mg/L)`) AS Avg_BOD
FROM river_wqi
GROUP BY River;

WITH Ranked AS
(
SELECT
    River,
    Station,
    AVG(WQI) AS Avg_WQI,
    ROW_NUMBER() OVER
    (
        PARTITION BY River
        ORDER BY AVG(WQI) DESC
    ) AS rn
FROM river_wqi
GROUP BY River,Station
)
SELECT *
FROM Ranked
WHERE rn=1;

SELECT
    River,
    AVG(WQI) AS Avg_WQI,
    DENSE_RANK() OVER
    (
        ORDER BY AVG(WQI) DESC
    ) AS River_Rank
FROM river_wqi
GROUP BY River;

SELECT
    `WQI Class`,
    COUNT(*) AS Total
FROM river_wqi
GROUP BY `WQI Class`;

CREATE VIEW RiverSummary AS
SELECT
    River,
    AVG(WQI) AS Avg_WQI,
    MAX(WQI) AS Max_WQI,
    MIN(WQI) AS Min_WQI
FROM river_wqi
GROUP BY River;

CREATE VIEW StationSummary AS
SELECT
    River,
    Station,
    AVG(WQI) AS Avg_WQI
FROM river_wqi
GROUP BY River,Station;


DROP VIEW RiverSummary;
DROP VIEW River_Summary;
DROP VIEW StationSummary;

