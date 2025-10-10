-- Query for creating Tiktok Table: 

CREATE TABLE tiktok_data (
    date DATE,
    campaign_id TEXT,
    campaign_name TEXT,
    adgroup_id TEXT,
    adgroup_name TEXT,
    impressions BIGINT,
    clicks BIGINT,
    cost NUMERIC,
    conversions BIGINT,
    video_views BIGINT,
    video_watch_25 BIGINT,
    video_watch_50 BIGINT,
    video_watch_75 BIGINT,
    video_watch_100 BIGINT,
    likes BIGINT,
    shares BIGINT,
    comments BIGINT
);


-- Query for creating Google Ads table:

CREATE TABLE google_ads_data (
    date DATE,
    campaign_id TEXT,
    campaign_name TEXT,
    adgroup_id TEXT,
    adgroup_name TEXT,
    keyword_id TEXT,
    keyword_text TEXT,
    impressions BIGINT,
    clicks BIGINT,
    cost NUMERIC,
    conversions BIGINT,
    view_through_conversions BIGINT,
    ctr NUMERIC,
    avg_cpc NUMERIC,
    cpc_bid BIGINT,
    conversions_value NUMERIC
);


Query for creating Facebook Table:

CREATE TABLE facebook_data (
    date DATE,
    campaign_id TEXT,
    campaign_name TEXT,
    ad_set_id TEXT,
    ad_set_name TEXT,
    impressions BIGINT,
    clicks BIGINT,
    spend NUMERIC,
    conversions BIGINT,
    video_views BIGINT,
    engagement_rate NUMERIC,
    reach BIGINT,
    frequency NUMERIC
);




--Query for unifying all 3 tables:



CREATE TABLE all_ads_data AS
SELECT 
    date, -- ok
    'Tiktok' as Platform, -- ok
    campaign_id, -- ok
    campaign_name, -- ok
    adgroup_id AS ad_group_id, -- ok
    adgroup_name AS ad_group_name, -- ok
    impressions,  -- ok
    clicks, -- ok
    cost, -- ok
    conversions, -- ok
    video_views, -- ok
    video_watch_25, -- ok
    video_watch_50, -- ok
    video_watch_75, -- ok
    video_watch_100, -- ok
    likes, -- ok
    shares, -- ok
    comments, -- ok
    NULL::NUMERIC AS conversion_value, --I dont have it in this table
    clicks:: float/ impressions AS ctr, -- could have it through (clicks/impressions) -- didnt multiply by 100 to keep patern from google ads. change in power bi
    cost/clicks AS avg_cpc, -- Could have it through cost/clicks
    NULL::BIGINT AS quality_score, -- given by google only
    NULL::NUMERIC AS search_impression_share, -- given by google only
    (likes+shares+comments+clicks)::float/impressions AS engagement_rate,--likes+shares+comments+clicks)/impressions - Didnt multiply by 100 to keep pattern from fb
    NULL::BIGINT AS reach, -- I dont have it in data
    NULL::NUMERIC AS frequency -- I dont have reach in this table
FROM tiktok_data

UNION ALL

SELECT
    date, -- ok
    'Google Ads' as Platform,
    campaign_id, -- ok
    campaign_name, -- ok
    ad_group_id, -- ok
    ad_group_name, -- ok
    impressions, -- ok
    clicks, -- ok
    cost, -- ok
    conversions, -- ok
    NULL::BIGINT AS video_views, --ok
    NULL::BIGINT AS video_watch_25, --ok
    NULL::BIGINT AS video_watch_50, -- ok
    NULL::BIGINT AS video_watch_75, -- ok
    NULL::BIGINT AS video_watch_100, -- ok
    NULL::BIGINT AS likes, -- ok
    NULL::BIGINT AS shares, -- ok
    NULL::BIGINT AS comments, -- ok
    conversion_value, -- ok
    ctr, -- ok
    avg_cpc, -- ok
    quality_score, -- ok
    search_impression_share, -- ok
    clicks::float/impressions AS engagement_rate, -- ok -- didnt multiply by 100 to keep pattern from fb. Change in pbi if needed.
    NULL::BIGINT AS reach, -- I dont have it -- ok
    NULL::NUMERIC AS frequency -- I dont have it -- ok
FROM google_ads_data

UNION ALL

SELECT
    date,
    'Facebook' as Platform,
    campaign_id, -- ok
    campaign_name, -- ok
    ad_set_id AS ad_group_id, -- ok
    ad_set_name AS ad_group_name, -- ok
    impressions, -- ok
    clicks, -- ok
    spend AS cost, -- ok
    conversions, -- ok
    video_views, -- ok
    NULL::BIGINT AS video_watch_25, --ok
    NULL::BIGINT AS video_watch_50,--ok
    NULL::BIGINT AS video_watch_75,--ok
    NULL::BIGINT AS video_watch_100,--ok
    NULL::BIGINT AS likes,--ok
    NULL::BIGINT AS shares,--ok
    NULL::BIGINT AS comments,--ok
    NULL::NUMERIC AS conversion_value,--ok
    clicks::FLOAT/impressions AS ctr, -- (clicks/impressions) -- didnt made times 100 to continue the pattern from google ads - Change in Power bi if needed
    spend/clicks AS avg_cpc,--ok
    NULL::BIGINT AS quality_score, -- ok
    NULL::NUMERIC AS search_impression_share, -- ok
    engagement_rate, -- ok
    reach, -- ok
    frequency -- ok
FROM facebook_data;