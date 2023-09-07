USE mavenfuzzyfactory;

SELECT 
	website_sessions.utm_content,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conversion_rate
    
FROM website_sessions 
	LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id

WHERE website_sessions.website_session_id BETWEEN 1 AND 2000

GROUP BY
	website_sessions.utm_content
    
ORDER BY 2 DESC;



SELECT 
	website_sessions.utm_source,
    website_sessions.utm_campaign,
    website_sessions.http_referer, 
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions
    
FROM website_sessions

WHERE website_sessions.created_at < '2012-04-12'

GROUP BY website_sessions.utm_source, website_sessions.utm_campaign, website_sessions.http_referer

ORDER BY sessions DESC



SELECT 
	COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conversion_rate

FROM website_sessions 
	LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id

WHERE website_sessions.created_at < '2012-04-14' AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'
	

ORDER BY sessions DESC;


SELECT 
	WEEK(created_at) AS week_start_date,
    COUNT(DISTINCT website_session_id) AS sessions
    
FROM website_sessions

WHERE created_at < '2012-05-10' AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'

GROUP BY 1
ORDER BY 2 DESC;



SELECT 
	(CASE WHEN device_type = 'mobile' THEN device_type WHEN device_type = 'desktop' THEN device_type ELSE NULL END) AS device_type,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
	COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id) AS cvr
FROM website_sessions
	LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2012-05-11' AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'
GROUP BY 1
ORDER BY 3 DESC, 4 DESC

	

SELECT
    MIN(DATE(created_at)) AS week_start_date,
	COUNT(CASE WHEN device_type = 'mobile' THEN device_type ELSE NULL END) AS m_sessions,
    COUNT(CASE WHEN device_type = 'desktop' THEN device_type ELSE NULL END) AS d_sessions
FROM website_sessions
WHERE created_at BETWEEN '2012-05-14' AND '2012-06-09' 
				 AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at), YEAR(created_at)
ORDER BY 2 DESC, 3 DESC;



-- Finding Top viewed Pages  - Extracting the most viewed pages 
SELECT 
	pageview_url,
    COUNT(DISTINCT website_pageview_id) AS pageviews
FROM website_pageviews
WHERE website_pageview_id < 1000
GROUP BY pageview_url
ORDER BY pageviews DESC;


-- Finding Top Entry Pages - Extracting the most pages viewed on first entry into the website using the concept of creating temporary pages

CREATE TEMPORARY TABLE first_pgview
SELECT 
	website_session_id,
    MIN(website_pageview_id) AS mpv
FROM website_pageviews
WHERE website_pageview_id < 1000
GROUP BY website_session_id;


SELECT 
    website_pageviews.pageview_url AS landing_page, -- "entry page"
    COUNT(DISTINCT first_pgview.website_session_id) AS sessions_hittting_this_lander
FROM  first_pgview
	LEFT JOIN website_pageviews ON first_pgview.mpv = website_pageviews.website_pageview_id
GROUP BY website_pageviews.pageview_url



SELECT
	pageview_url,
	COUNT(DISTINCT website_session_id) AS sessions
 FROM website_pageviews
 WHERE created_at < '2012-06-09'
GROUP BY pageview_url
ORDER BY 2 DESC;



CREATE TEMPORARY TABLE Initial_view
SELECT 
	website_session_id,
    MIN(website_pageview_id) AS mpv
FROM website_pageviews
GROUP BY website_session_id;


SELECT
	website_pageviews.pageview_url AS landing_page,
    COUNT(DISTINCT Initial_view.website_session_id) AS sessions_hitting_this_landing_page
FROM Initial_view
	LEFT JOIN website_pageviews ON Initial_view.mpv = website_pageviews.website_session_id
WHERE website_pageviews.created_at < '2012-06-12'
GROUP BY 1
ORDER BY 2 DESC;



SELECT 
	website_pageviews.website_session_id,
    MIN(website_pageviews.website_pageview_id) AS min_pageview_id
FROM website_pageviews
	INNER JOIN website_sessions ON website_pageviews.website_session_id = website_sessions.website_session_id
WHERE website_pageviews.created_at BETWEEN '2014-01-01' AND '2014-02-01'
GROUP BY 1;


CREATE TEMPORARY TABLE first_pageviews_demo
SELECT 
	website_pageviews.website_session_id,
    MIN(website_pageviews.website_pageview_id) AS min_pageview_id
FROM website_pageviews
	INNER JOIN website_sessions ON website_pageviews.website_session_id = website_sessions.website_session_id
WHERE website_pageviews.created_at BETWEEN '2014-01-01' AND '2014-02-01'
GROUP BY 1;


CREATE TEMPORARY TABLE sessions_w_landing_page_demo
SELECT 
	first_pageviews_demo.website_session_id,
    website_pageviews.pageview_url AS landing_page
FROM first_pageviews_demo 
	INNER JOIN website_pageviews ON website_pageviews.website_pageview_id = first_pageviews_demo.min_pageview_id ;-- website pageview is the landing page


CREATE TEMPORARY TABLE bounced_sessions_only
SELECT 
	sessions_w_landing_page_demo.website_session_id,
    sessions_w_landing_page_demo.landing_page,
    COUNT(website_pageviews.website_pageview_id) AS count_of_pages_viewed
FROM sessions_w_landing_page_demo
	LEFT JOIN website_pageviews ON sessions_w_landing_page_demo.website_session_id = website_pageviews.website_session_id
GROUP BY 1, 2
HAVING count_of_pages_viewed = 1;


SELECT 
	sessions_w_landing_page_demo.landing_page,
	COUNT(sessions_w_landing_page_demo.website_session_id) AS sessions,
    COUNT(bounced_sessions_only.website_session_id) AS bounced_sessions,
	COUNT(bounced_sessions_only.website_session_id)/COUNT(sessions_w_landing_page_demo.website_session_id) AS bounce_rate
FROM sessions_w_landing_page
	INNER JOIN bounced_sessions_only ON sessions_w_landing_page.website_session_id = bounced_sessions_only.website_session_id
GROUP BY 2,3


	






















