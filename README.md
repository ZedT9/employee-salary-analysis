# Employee Salary & Career Growth Analysis

A SQL + Python analysis of a relational HR database, focused on how compensation evolves over an employee's career — not just what people earn, but how they got there.

## Overview

This project uses the **Employees** database, a relational dataset modeling a real corporate HR system: employee records, departments, job titles, and salary history spanning decades, with every change tracked via `from_date`/`to_date` ranges. The data was loaded into PostgreSQL and analyzed using SQL, with results pulled into Python (pandas, matplotlib) for further analysis and visualization.

The central question: **does staying longer at a company pay off, and how does that differ from just getting bigger individual raises?** The analysis treats compensation as a panel — tracking individual salary trajectories over time rather than looking at a single point-in-time snapshot.

## Tools

- **PostgreSQL** — relational database, schema design, data loading
- **SQL** — joins, CTEs, window functions, self-joins, date-range joins
- **Python** — pandas for analysis, matplotlib for visualization
- **Jupyter Notebook** — combining SQL, Python, and documentation in one place

## Dataset

Source: [Employees Database — Kaggle](https://www.kaggle.com/datasets/priyankbarbhaya/sql-analytics-case-study-employees-database)

Six relational tables:
- `employees` — core biographical/hire info
- `departments` — department names
- `dept_emp` — which employee worked in which department, and when
- `dept_manager` — who managed which department, and when
- `titles` — job title history per employee
- `salaries` — salary history per employee

## SQL Techniques Used

| Technique | Where it's used |
|---|---|
| Multi-table joins | Building a "current status" snapshot per employee |
| CTEs | Chaining multi-step logic (e.g. current salary → department → department average) |
| Window functions (`RANK()`, `AVG() OVER()`) | Ranking employees by salary within their department |
| `LAG()` | Comparing each salary record to the previous one, per employee |
| Self-joins | Matching employees to their department's manager via the `employees` table joined to itself |
| Date-range joins | Matching salary records to whichever title was active *at that time*, not just currently |
| `DISTINCT ON` (Postgres-specific) | Grabbing each employee's very first salary record |
| `WIDTH_BUCKET` | Bucketing employees into tenure ranges for aggregate comparison |

## Key Findings

1. **Individual raise size is fairly consistent across titles** (roughly 3-4% per raise), with junior titles seeing marginally larger and more variable raises than senior ones.
2. **Total career growth varies enormously by title** — but this is driven by tenure, not raise generosity. Senior Engineers show ~48% total growth from hire to now, despite smaller individual raises, simply because they've had more years for raises to compound.
3. **Salary growth scales steadily with tenure**, with no evidence of plateauing within the tenure ranges available in this dataset — the longer someone stays, the more their compensation compounds.

## Repository Structure

```
├── employee_analysis.ipynb    # Main notebook: SQL queries, analysis, visualizations
├── schema.sql                  # PostgreSQL schema + data loading script
├── data/                       # Source CSVs (from Kaggle)
├── raise_vs_growth_by_title.png
├── tenure_vs_growth.png
├── .gitignore
└── README.md
```

## Reproducing This Analysis

1. Install PostgreSQL and create a database:
   ```sql
   CREATE DATABASE employees_db;
   ```
2. Load the schema and data:
   ```bash
   psql -U postgres -d employees_db -f schema.sql
   ```
3. Create a `.env` file with your database password:
   ```
   DB_PASSWORD=your_password_here
   ```
4. Install Python dependencies:
   ```bash
   pip install pandas sqlalchemy psycopg2-binary matplotlib python-dotenv jupyter
   ```
5. Run the notebook:
   ```bash
   jupyter notebook employee_analysis.ipynb
   ```

## Notes

- Database credentials are stored in a `.env` file (excluded from version control) rather than hardcoded, to avoid exposing passwords in the notebook.
- This dataset is synthetic — while structurally realistic, findings reflect patterns in generated data rather than a real company's actual compensation practices.
