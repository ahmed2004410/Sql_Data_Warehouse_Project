# 📊 SQL Data Warehouse Project

Welcome to the **SQL Data Warehouse Project** 🚀  
This project demonstrates how to design and build a **modern data warehouse** following the **Medallion Architecture** (Bronze, Silver, Gold layers) and apply analytics using SQL and BI tools.  

---

## 🏗️ Data Architecture (Medallion Layers)

The project is structured using **3 layers**:  

1. 🥉 **Bronze Layer**  
   - Stores raw data directly from the source systems (CSV files).  
   - No transformations, just ingestion for traceability.  

2. 🥈 **Silver Layer**  
   - Data cleansing, standardization, and normalization.  
   - Ensures consistency and prepares data for analytics.  

3. 🥇 **Gold Layer**  
   - Business-ready, analytical models (Star Schema).  
   - Used for reporting and dashboard creation.  

---

## 📖 Project Overview

This project covers:  
- **Data Architecture**: Medallion (Bronze, Silver, Gold).  
- **ETL Pipelines**: Extract, Transform, Load into SQL Server.  
- **Data Modeling**: Fact & Dimension tables for analysis.  
- **Analytics & Reporting**: Insights using SQL queries and BI dashboards.  

---

## 🛠️ Tools & Resources

- **SQL Server Express** → Database engine.  
- **SSMS (SQL Server Management Studio)** → Query & management tool.  
- **Power BI** → Dashboards & visualizations.  
- **Excel & Power Query** → Data preparation.  
- **DrawIO** → Architecture & ERD diagrams.  

---
## 📂 Repository Structure

SQL_Data_Warehouse_Project/
│
├── datasets/ # Raw datasets used for the project (ERP and CRM data)
│
├── docs/ # Project documentation and architecture details
│ ├── etl.drawio # ETL process diagram
│ ├── data_architecture.drawio # Project architecture diagram
│ ├── data_catalog.md # Dataset catalog and metadata
│ ├── data_flow.drawio # Data flow diagram
│ ├── data_models.drawio # Star schema data model
│ ├── naming-conventions.md # Naming guidelines
│
├── scripts/ # SQL scripts for ETL and transformations
│ ├── bronze/ # Raw data ingestion
│ ├── silver/ # Cleansed & standardized data
│ └── gold/ # Business-ready star schema
│
├── tests/ # Test queries & data quality checks
│
├── README.md # Project overview and instructions
├── LICENSE # License information
├── .gitignore # Ignored files
└── requirements.txt # Dependencies


---

## 📊 Analytics & Reporting

The warehouse supports insights on:  
- **Customer Behavior** 👥  
- **Product Performance** 📦  
- **Sales Trends** 💰  

Dashboards built in **Power BI** provide interactive reports for decision-making.  

---

## 🌐 Connect with Me

I’m **Ahmed Anwer Fath** 👋  
📌 Passionate about Data Warehousing, ETL, SQL Development, and BI.  

- 🔗 [LinkedIn](https://www.linkedin.com/in/ahmed-anwer-fath77)  
- 🖥️ [GitHub](https://github.com/ahmed2004410)  

---

## 🛡️ License

This project is licensed under the **MIT License**.  
You are free to use, modify, and share with proper attribution.  

---
