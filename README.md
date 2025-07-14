# CovidInSql

# COVID-19 Data Analysis SQL Project
following this tutorial [Click here](https://www.youtube.com/watch?v=qfyynHBFOsM&t=2163s) made by Alex

## Project Description
This repository contains SQL queries for analyzing COVID-19 data from two primary tables: `CovidDeaths` and `CovidVaccinations`. The analysis focuses on calculating key metrics like death percentages and infection rates, with particular attention to locations containing the word "state".

## Key Features
- Death rate analysis (deaths as percentage of total cases)
- Infection rate analysis (cases as percentage of population)
- Data quality handling with TRY_CAST operations
- Focus on US states (through location filtering)

## SQL Queries Overview

### 1. Basic Data Exploration
<img width="745" height="767" alt="sql1" src="https://github.com/user-attachments/assets/e7210c37-291a-4f97-98af-cb474d57defc" />

- Retrieves sample vaccination data identifiers

### 2. Death Percentage Calculation
<img width="788" height="823" alt="sql2" src="https://github.com/user-attachments/assets/0788b76b-cb4e-40b4-a270-7e79df680105" />

```
- Calculates mortality rate by location and date
- Filters for US states


### 3. Population Infection Rate

<img width="930" height="817" alt="sql3" src="https://github.com/user-attachments/assets/db0c5a6c-bac6-4343-9d90-525c598bfb3c" />

- Calculates what percentage of population was infected
- Includes null handling for zero population values


## Data Source
The queries assume data is stored in a SQL Server database called `PortfolioProject` with tables:
- `CovidDeaths` (case and death statistics)
- `CovidVaccinations` (vaccination records)
you can download it from [here]
