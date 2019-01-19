SELECT
date, 
recipeid,
recipeinstanceid,
site,
domain,
landing_page_url,
clicks,
impressions,
ctr,
position
FROM 
  ( 
	SELECT  
	date, 
	recipeid,
	recipeinstanceid,
	site,
	domain,
	clicks,
	impressions,
	ctr,
	position,
	lower(trim(regexp_replace(replace(replace(replace(replace(landing_page,'www.',''),'http://',''),'https://',''),'.html',''),r'\?.*$',''),'/')) as landing_page_url,
	enteredon,
	first_value(enteredon) OVER (PARTITION BY site, domain, landing_page, date ORDER BY enteredon DESC) lv
	FROM `{{ target.project }}.organic_acquisition_by_landing_page.google_webmasters_data_source`

  ) 
where lv = enteredon