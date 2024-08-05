-- Total number of marketing_qualified_leads
SELECT COUNT(*) AS Total_mqls
FROM olist_marketing_qualified_leads;

-- Totalnumber of closed deals
SELECT COUNT(*) AS closed_deals
FROM olist_closed_deals;

-- Lead Conversion Rate
SELECT
     (SELECT COUNT(*) FROM olist_closed_deals)/
     (SELECT COUNT(*) FROM olist_marketing_qualified_leads)
     *100 AS conversion_rate;
     
-- Average Deal Size
SELECT 
    AVG(declared_monthly_revenue) AS average_deal_size
FROM 
    olist_closed_deals
WHERE
    declared_monthly_revenue IS NOT NULL;

-- Total Revenue
SELECT 
    SUM(declared_monthly_revenue) AS total_revenue
FROM 
    olist_closed_deals
WHERE
    declared_monthly_revenue IS NOT NULL;
    
-- Average Catalog Size 
SELECT 
    AVG(declared_product_catalog_size) AS average_catalog_size
FROM 
    olist_closed_deals
WHERE
    declared_product_catalog_size IS NOT NULL;

-- Average Sales Cycle(Days)
SELECT 
    AVG(DATEDIFF(won_date, first_contact_date)) AS average_sales_cycle
FROM 
    olist_marketing_qualified_leads mql
JOIN 
    olist_closed_deals cd ON mql.mql_id = cd.mql_id
WHERE
    won_date IS NOT NULL AND first_contact_date IS NOT NULL;

-- Lead Type 
SELECT 
    lead_type, COUNT(*) AS count
FROM 
    olist_closed_deals
GROUP BY lead_type;

-- Transformed the lead type into online and offline
SELECT 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END AS grouped_lead_type,
    COUNT(*) AS lead_count
FROM 
    olist_closed_deals
GROUP BY 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END;

-- Calculating Total Revenue by the Lead Type
SELECT 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END AS grouped_lead_type,
    SUM(declared_monthly_revenue) AS total_revenue
FROM 
    olist_closed_deals
GROUP BY 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END;
    
-- Average Declared Product Catalog size by Lead Type 
SELECT 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END AS grouped_lead_type,
    AVG(declared_product_catalog_size) AS average_catalog_size
FROM 
    olist_closed_deals
GROUP BY 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END;

-- Average Sales Cycle in Days/Lead Conversion Time by Lead type 
SELECT 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END AS grouped_lead_type,
    AVG(DATEDIFF(won_date, first_contact_date)) AS average_sales_cycle_days
FROM 
    olist_closed_deals AS ocd
JOIN 
    olist_marketing_qualified_leads AS omql ON ocd.mql_id = omql.mql_id
GROUP BY 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END;
    
-- Analyzing Business Category by lead type 
SELECT 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END AS grouped_lead_type,
    CASE
        WHEN business_type IS NULL OR business_type = '' THEN 'Other'
        ELSE business_type
    END AS adjusted_business_type,
    COUNT(*) AS count_of_business_type
FROM 
    olist_closed_deals
GROUP BY 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END,
    CASE
        WHEN business_type IS NULL OR business_type = '' THEN 'Other'
        ELSE business_type
    END
ORDER BY 
    grouped_lead_type,
    count_of_business_type DESC;
    
-- Analyzing the Total Revenue by Business Category and Lead type 
SELECT 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END AS grouped_lead_type,
    CASE
        WHEN business_type IS NULL OR business_type = '' THEN 'Other'
        ELSE business_type
    END AS adjusted_business_type,
    SUM(declared_monthly_revenue) AS total_revenue
FROM 
    olist_closed_deals
GROUP BY 
    CASE 
        WHEN lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN lead_type IN ('industry', 'offline', 'other', '') OR lead_type IS NULL THEN 'Offline'
    END,
    CASE
        WHEN business_type IS NULL OR business_type = '' THEN 'Other'
        ELSE business_type
    END
ORDER BY 
    grouped_lead_type,
    total_revenue DESC;

-- Average Product Catalog Size of the business type given the lead type
SELECT 
    CASE 
        WHEN d.lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN d.lead_type IN ('industry', 'offline', 'other', '') OR d.lead_type IS NULL THEN 'Offline'
    END AS grouped_lead_type,
    CASE
        WHEN d.business_type IS NULL OR d.business_type = '' THEN 'Other'
        ELSE d.business_type
    END AS adjusted_business_type,
    AVG(DATEDIFF(d.won_date, l.first_contact_date)) AS average_sales_cycle_days
FROM 
    olist_closed_deals d
JOIN 
    olist_marketing_qualified_leads l
ON 
    d.mql_id = l.mql_id
WHERE 
    d.won_date IS NOT NULL AND l.first_contact_date IS NOT NULL
GROUP BY 
    CASE 
        WHEN d.lead_type IN ('online_medium', 'online_big', 'online_small', 'online_top', 'online_beginner') THEN 'Online'
        WHEN d.lead_type IN ('industry', 'offline', 'other', '') OR d.lead_type IS NULL THEN 'Offline'
    END,
    CASE
        WHEN d.business_type IS NULL OR d.business_type = '' THEN 'Other'
        ELSE d.business_type
    END
ORDER BY 
    grouped_lead_type,
    average_sales_cycle_days DESC;
    
-- Analyzing the Business Segment column
SELECT business_segment,COUNT(*) AS count_of_business_segment
FROM  olist_closed_deals
GROUP BY business_segment
ORDER BY count_of_business_segment DESC;

-- Analyzing Total Revenue by Business segment
SELECT 
    CASE
        WHEN d.business_segment IS NULL OR d.business_segment = '' THEN 'Other'
        ELSE d.business_segment
    END AS adjusted_business_segment,
    SUM(d.declared_monthly_revenue) AS total_revenue
FROM 
    olist_closed_deals d
GROUP BY 
    CASE
        WHEN d.business_segment IS NULL OR d.business_segment = '' THEN 'Other'
        ELSE d.business_segment
    END
ORDER BY 
    total_revenue DESC;
    
-- Average Product Catalog Size by Business segment
SELECT 
    CASE
        WHEN d.business_segment IS NULL OR d.business_segment = '' THEN 'Other'
        ELSE d.business_segment
    END AS adjusted_business_segment,
    AVG(d.declared_product_catalog_size) AS average_catalog_size
FROM 
    olist_closed_deals d
GROUP BY 
    CASE
        WHEN d.business_segment IS NULL OR d.business_segment = '' THEN 'Other'
        ELSE d.business_segment
    END
ORDER BY 
    average_catalog_size DESC;
    
-- Average Sales Cycle(Days)/Lead Conversion Time by Business segment
SELECT 
    CASE
        WHEN d.business_segment IS NULL OR d.business_segment = '' THEN 'Other'
        ELSE d.business_segment
    END AS adjusted_business_segment,
    AVG(DATEDIFF(d.won_date, l.first_contact_date)) AS average_sales_cycle_days
FROM 
    olist_closed_deals d
JOIN 
    olist_marketing_qualified_leads l
ON 
    d.mql_id = l.mql_id
WHERE 
    d.won_date IS NOT NULL AND l.first_contact_date IS NOT NULL
GROUP BY 
    CASE
        WHEN d.business_segment IS NULL OR d.business_segment = '' THEN 'Other'
        ELSE d.business_segment
    END
ORDER BY 
    average_sales_cycle_days DESC;

-- Closed Deals by Month
SELECT 
    DATE_FORMAT(d.won_date, '%Y-%m') AS month_year,
    COUNT(*) AS number_of_closed_deals
FROM 
    olist_closed_deals d
GROUP BY 
    DATE_FORMAT(d.won_date, '%Y-%m')
ORDER BY 
    month_year;

-- Analysis of Lead Behaviour profile
SELECT 
    lead_behaviour_profile,
    COUNT(*) AS count_of_lead_behaviour
FROM 
    olist_closed_deals
GROUP BY 
    lead_behaviour_profile
ORDER BY 
    count_of_lead_behaviour DESC;
    
-- Categorizing the number of closed deals by Lead behaviour profile 
SELECT 
    CASE
        WHEN lead_behaviour_profile LIKE '%cat%' THEN 'Cat'
        WHEN lead_behaviour_profile LIKE '%eagle%' THEN 'Eagle'
        WHEN lead_behaviour_profile LIKE '%shark%' THEN 'Shark'
        WHEN lead_behaviour_profile IS NULL OR lead_behaviour_profile = '' THEN 'Unknown'
        ELSE 'Other' -- For any unforeseen values
    END AS categorized_lead_behaviour_profile,
    COUNT(*) AS number_of_closed_deals
FROM 
    olist_closed_deals
GROUP BY 
    CASE
        WHEN lead_behaviour_profile LIKE '%cat%' THEN 'Cat'
        WHEN lead_behaviour_profile LIKE '%eagle%' THEN 'Eagle'
        WHEN lead_behaviour_profile LIKE '%shark%' THEN 'Shark'
        WHEN lead_behaviour_profile IS NULL OR lead_behaviour_profile = '' THEN 'Unknown'
        ELSE 'Other' -- For any unforeseen values
    END
ORDER BY 
    number_of_closed_deals DESC;

-- Average Deal Size by Lead Behaviour Profile
WITH LeadBehaviourSummary AS (
    SELECT 
        CASE
            WHEN lead_behaviour_profile LIKE '%cat%' THEN 'Cat'
            WHEN lead_behaviour_profile LIKE '%eagle%' THEN 'Eagle'
            WHEN lead_behaviour_profile LIKE '%shark%' THEN 'Shark'
            WHEN lead_behaviour_profile IS NULL OR lead_behaviour_profile = '' THEN 'Unknown'
            ELSE 'Other' -- For any unforeseen values
        END AS categorized_lead_behaviour,
        SUM(declared_monthly_revenue) AS total_revenue,
        COUNT(*) AS number_of_closed_deals
    FROM 
        olist_closed_deals
    GROUP BY 
        CASE
            WHEN lead_behaviour_profile LIKE '%cat%' THEN 'Cat'
            WHEN lead_behaviour_profile LIKE '%eagle%' THEN 'Eagle'
            WHEN lead_behaviour_profile LIKE '%shark%' THEN 'Shark'
            WHEN lead_behaviour_profile IS NULL OR lead_behaviour_profile = '' THEN 'Unknown'
            ELSE 'Other' -- For any unforeseen values
        END
)
SELECT 
    categorized_lead_behaviour,
    CASE 
        WHEN number_of_closed_deals > 0 THEN total_revenue / number_of_closed_deals
        ELSE 0
    END AS average_deal_size
FROM 
    LeadBehaviourSummary
ORDER BY 
    average_deal_size DESC;




    







