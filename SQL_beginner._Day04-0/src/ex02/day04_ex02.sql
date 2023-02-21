CREATE VIEW V_GENERATED_DATES AS 
	SELECT
	    date(
	        generate_series(
	            DATE '2022-01-01',
	            DATE '2022-01-31',
	            '1 day'
	        )
	    ) AS generated_date
	ORDER BY
GENERATED_DATE; 