# Olist Sales Funnel Analysis

## Overview
 This project is designed to show an analysis of a marketing funnel dataset from the Olist Store, focusing on MQLs (Marketing Qualified Leads) and their journey to become closed deals. This dataset contains requests for contact between June 1, 2017, and June 1, 2018. The objective is to analyze the sales process to uncover insights and propose actionable recommendations to improve marketing and sales strategies.

## Business Question
How can Olist increase the conversion rates and maximize revenues by improving marketing and sales across different channels and product categories?

## Description of the dataset
The dataset is divided into two major files:

- **`olist_marketing_qualified_leads_dataset.csv`:** Contains metadata of all MQLs, such as marketing qualified lead ID, first contact date, landing page, origin of the lead.
- **`olist_closed_deals_dataset.csv`:** Details of the closed deals, whether MQL ID, Seller ID, SDR ID, SR ID, Won date, Business segment, or lead type, Lead behavior profile, among other business details.

### Key Features
- **Lead Identification: ** `mql_id`, `seller_id`, `sdr_id`, `sr_id`
- **Lead Attributes:** `first_contact_date`, `landing_page_id`, `origin`, `lead_type`, `lead_behaviour`, `has_company`, `has_gtin`
- **Business Metrics:** `average_stock`, `business_type`, `declared_product_catalog_size`, `declared_monthly_revenue`
- **Sales Metrics:** `won_date`, `business_segment`

## Key Metrics
- **Total MQLs:** 8,000
- **Closed Deals:** 842
- **Lead Conversion Rate:** 10.53%
- **Total Revenue:** $61.78M
- **Average Deal Size:** $73.38K
- **Revenue by Lead Type:**
  - **Online:** $10.37M
  - **Offline:** $51.41M
- **Top Revenue Generating Segment: **
  - **Construction, Tools, House & Garden:** $50.7M
  - **Phones & Mobile:** $8M

## Insights
1. **Offline Leads Dominance:**
    Offline leads generate significantly higher revenue compared to online leads,even though they have a low lead conversion rate compared to online leads.
2. **Segment-Specific Revenue:**
    Construction, Tools, House & Garden remains an important revenue driver, contribute a majority total revenue.

3. **High-Value Lead Profiles:**
   The Shark profile exhibits the highest average deal size, indicating it is a high-value lead profile

## Recommendations
1. **Enhance Offline Marketing:**
   Implement strategies to optimize the revenue gains from offline leads.

2. **Target High-Revenue Segments:**
   Focus marketing on the Construction, Tools, House & Garden segment, which generated maximum revenues.

3. **Optimize Lead Handling for 'Shark' Profile:**
   Develop specialized strategies and prioritizing efforts towards this lead profile could yield significant returns

5. **Investigate Sales Cycle Duration:**
   Investigate and address the extended sales cycle for leads in the 'Other' business category, particularly for offline leads.



Nb: This is a project based on anonymized and sampled real data from the Olist Store. Analysis and recommendations are hence based on the available dataset, and therefore, they are trying to bring actionable insights that would be relevant to improve marketing and sales strategies.
