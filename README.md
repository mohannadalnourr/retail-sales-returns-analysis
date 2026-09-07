# Retail Sales & Returns Analysis

An end-to-end analytics project exploring where a retail business is losing money on discounts, and which regions need attention — built using SQL, Python, Excel, and Power BI.

## The Question

Where is the company losing money on deep discounts, and which regions need attention?

## Tools Used

- **SQL (PostgreSQL)** — data cleaning checks and core analysis queries
- **Python (pandas, matplotlib)** — verification of SQL results and quick visualizations
- **Excel** — PivotTables, formulas, and a category/region breakdown
- **Power BI** — interactive dashboard with KPIs, charts, and filters

## Key Findings

- **Furniture's profit margin is just 2.5%**, compared to roughly 17% for Office Supplies and Technology.
- Furniture gets discounted 21% or more in **1 out of every 4 sales** — other categories see this in roughly 1 out of 10. Once a discount crosses that 21% line, average profit turns negative.
- **West** has the highest return rate (~11%, more than double every other region), but it's also the most profitable region overall, largely due to sales volume.
- **Central** looks completely normal on returns, but it's quietly the weakest region on profit — a problem that would be easy to miss looking at only one metric.

## Repo Structure

├── sql/ → Queries used for data cleaning and analysis

├── python/ → Jupyter notebook verifying SQL results and building charts

├── excel/ → Workbook with PivotTables, formulas, and cleaning notes

└── powerbi/ → Interactive Power BI dashboard (.pbix)


## Dataset

[Tableau Sample Superstore dataset](https://www.kaggle.com/datasets/dougvernon/tableau-sample-superstore) — orders, returns, and regional data, sourced via Kaggle.
