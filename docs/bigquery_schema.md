# BigQuery Table Schema

**Project:** `startups-sql-data-portfolio`  
**Dataset:** `startup_funding`  
**Table:** `startup_data`  
**SQL Engine:** BigQuery Standard SQL  
**Rows Analyzed:** 1,576  

This schema was exported from BigQuery using `INFORMATION_SCHEMA.COLUMNS`.

| Field Name | Data Type | Nullable |
|---|---|---|
| `Organization_Name` | STRING | YES |
| `Organization_Name_URL` | STRING | YES |
| `Founded_Date` | DATE | YES |
| `Founders` | STRING | YES |
| `Number_of_Employees` | STRING | YES |
| `Description` | STRING | YES |
| `Industries` | STRING | YES |
| `Industry_Groups` | STRING | YES |
| `Headquarters_Location` | STRING | YES |
| `Headquarters_Regions` | STRING | YES |
| `Operating_Status` | STRING | YES |
| `Funding_Status` | STRING | YES |
| `Number_of_Funding_Rounds` | INT64 | YES |
| `Last_Funding_Amount` | FLOAT64 | YES |
| `Last_Funding_Amount_Currency` | STRING | YES |
| `Last_Funding_Date` | DATE | YES |
| `Last_Funding_Type` | STRING | YES |
| `Total_Funding_Amount` | FLOAT64 | YES |
| `Total_Funding_Amount_Currency` | STRING | YES |
| `Number_of_Lead_Investors` | FLOAT64 | YES |
| `Top_5_Investors` | STRING | YES |
| `Trend_Score_7_Days` | FLOAT64 | YES |
| `Trend_Score_30_Days` | FLOAT64 | YES |
| `Trend_Score_90_Days` | FLOAT64 | YES |
| `Growth_Trend` | STRING | YES |
| `Active_Hiring` | BOOL | YES |
| `Region_Local` | STRING | YES |
| `Region_Mid` | STRING | YES |
| `Region_Broad` | STRING | YES |
| `Industry_Category` | STRING | YES |
| `Founded_Year` | INT64 | YES |
| `Last_Funding_Year` | INT64 | YES |
| `State` | STRING | YES |

## Notes

- `Industry_Category`, `State`, `Founded_Year`, and `Last_Funding_Year` were created or standardized during the Python cleaning process.
- `Total_Funding_Amount` is used for funding aggregation and ranking.
- `Active_Hiring` is used as a hiring-related signal, not as confirmed hiring intent.
- `Trend_Score_30_Days` is used as a recent market attention or trend signal.
