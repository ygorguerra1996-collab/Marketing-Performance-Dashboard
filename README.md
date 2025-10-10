
# Marketing Performance Dashboard

This repository contains the SQL script and documentation used for data transformation and unified model creation for the Marketing Data Analyst technical assignment.

## Dashboard Link
[Power BI Dashboard] (https://app.powerbi.com/view?r=eyJrIjoiOTU1MGNkNWQtNzJhMy00M2RhLTk5MDgtMTVjYTUyMjYyY2VjIiwidCI6IjkyYzZmMWNjLTQzYjUtNDA5MC1hN2EwLWQ1NzA0Nzg3ZjFhZSJ9)


## Project Overview
The dashboard compares performance across three platforms: TikTok, Facebook Ads, and Google Ads. It provides insights into campaign effectiveness through visualizations of:

- Conversions by campaign
- Cost vs. conversions (bubble chart)
- Funnel metrics: Engagement Rate (ER), Click-Through Rate (CTR), Conversion Rate (CVR)
- Funnel performance by day of the week
- Platform-specific performance with dynamic tooltips
    The dynamic tooltips can be seen by hovering over the columns of each platform. The tooltip that will pop-up is regarding metrics that are specific to each platform.
    The SIS used in Google ads tooltip was weighted by impressions, to give more weight to ads with higher number of impressions

## SQL Script
The `sql/transform_and_unify_model.sql` script includes:

- Data cleaning and preparation
- Data from CSV files was ingested into the database using DBeaver for efficiency.
- Joining and harmonizing metrics across platforms, by UNION ALL, to ensure all columns are preserved.
