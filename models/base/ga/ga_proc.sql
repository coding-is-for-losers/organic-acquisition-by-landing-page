SELECT
date, 
recipeid,
recipeinstanceid,
site,
domain,
landing_page_url,
sum(sessions) sessions,
sum(goal_completions_all) goal_completions_all
FROM (

	SELECT
	date, 
	recipeid,
	recipeinstanceid,
	site,
	domain,
	landing_page_url,
	sessions,
	goal_completions_all
	lower(trim(regexp_replace(replace(replace(replace(replace(CONCAT(hostname,landing_page_path),'www.',''),'http://',''),'https://',''),'.html',''),r'\?.*$',''),'/')) as landing_page_url,
	enteredon,
	first_value(enteredon) OVER (PARTITION BY hostname, landingpagepath, date, source, medium ORDER BY _sdc_sequence DESC) lv
	FROM `{{ target.project }}.organic_acquisition_by_landing_page.google_analytics_data_source`
)
WHERE lv = enteredon
AND medium = 'organic'
GROUP BY date, recipeid, recipeinstanceid, site, domain, landing_page_url