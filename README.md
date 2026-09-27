# Nashville Housing Data Cleaning – SQL

## Project Overview

This project focuses on cleaning and standardizing the Nashville Housing dataset using SQL. The goal was to improve data quality, consistency, and structure to prepare the dataset for further analysis.

## Objectives

- Standardize date formats
- Handle missing property address data
- Split address information into separate fields
- Standardize categorical values
- Identify duplicate records
- Remove unnecessary columns
- Prepare the dataset for analysis

## Tools Used

- SQL Server
- SQL

## Data Cleaning Tasks

### 1. Standardizing Date Format

Converted the `SaleDate` field to a date format and created a separate `SaledDateConverted` column to store the standardized date.

### 2. Populating Missing Property Addresses

Used `ParcelID` to identify matching records and populated missing `PropertyAddress` values using `ISNULL()`.

### 3. Splitting Property Addresses

Separated the property address into:

- Property Address
- Property City

using SQL string functions such as `SUBSTRING()`, `CHARINDEX()`, and `LEN()`.

### 4. Splitting Owner Addresses

Separated the owner address into:

- Owner Address
- Owner City
- Owner State

using `PARSENAME()` and `REPLACE()`.

### 5. Standardizing Sold-As-Vacant Values

Standardized the `SoldAsVacant` field by converting:

- `Y` → `Yes`
- `N` → `No`

### 6. Identifying Duplicate Records

Used `ROW_NUMBER()` with a Common Table Expression (CTE) to identify duplicate records based on selected housing attributes.

### 7. Removing Unused Columns

Removed columns that were no longer needed after the data transformation:

- `PropertyAddress`
- `SaleDate`
- `TaxDistrict`
- `OwnerAddress`

## Dataset

The project uses the Nashville Housing dataset containing more than 56,000 housing records.

The original dataset is included in the `data` folder.

## Skills Demonstrated

- SQL
- Data Cleaning
- Data Transformation
- Data Quality Management
- String Manipulation
- Common Table Expressions (CTEs)
- Window Functions
- Data Preparation

## Project Structure

```text
Nashville-Housing-SQL/
│
├── README.md
│
├── data/
│   └── NashvilleHousing.xlsx
│
└── sql/
    └── Nashville_Housing_Cleaning.sql
