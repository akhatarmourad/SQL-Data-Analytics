-- Select all products
SELECT * FROM product;

-- FIRST_VALUE : Select most expensive product by category
SELECT *,
	FIRST_VALUE(product_name) OVER(PARTITION BY product_category ORDER BY price DESC)
	AS most_expensive
FROM product;

-- LAST_VALUE & FRAME : Select most & least expensive product by category
SELECT *,
	FIRST_VALUE(product_name)
	OVER(PARTITION BY product_category ORDER BY price DESC)
	AS most_expensive,

	LAST_VALUE(product_name)
	OVER(PARTITION BY product_category ORDER BY price DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
	AS least_expensive
FROM product;

-- RANGE & ROWS : Show difference between range & rows
SELECT *,
	LAST_VALUE(product_name)
	OVER w_range
	AS least_expensive_range,

	LAST_VALUE(product_name)
	OVER w_rows
	AS least_expensive_rows
FROM product
WINDOW
	w_range AS (PARTITION BY product_category ORDER BY price DESC RANGE BETWEEN 2 PRECEDING AND CURRENT ROW),
	w_rows AS (PARTITION BY product_category ORDER BY price DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);

-- NTH_VALUE : Get the n-th most expensive product by category
SELECT *,
	NTH_VALUE(product_name, 2) OVER w AS second_most_expensive
FROM product
	WINDOW w
	AS (PARTITION BY product_category ORDER BY price DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);

-- Segregate data into distinct groups
SELECT product_name,
	CASE 
		WHEN res.bucket = 1 THEN 'Expensive'
		WHEN res.bucket = 2 THEN 'Medium'
		WHEN res.bucket = 3 THEN 'Cheaper'
	END AS product_type
FROM (
	SELECT *,
		NTILE(3) OVER(ORDER BY price DESC) AS bucket
	FROM product
	WHERE product_category = 'Phone'
) res;


-- Cumulative Distribution
SELECT product_name, price, (cumulative_distribution || '%') AS cum_dist_percent
FROM (
	SELECT *,
		ROUND(CUME_DIST() OVER(ORDER BY price DESC)::numeric * 100, 2)  AS cumulative_distribution
	FROM product
) res WHERE res.cumulative_distribution < 30;

-- Percentage Ranking : (Row No - 1) / (Total Rows No - 1)
SELECT *, (res.percent_rank || '%') AS percent_ranking
FROM (
	SELECT *,
		ROUND(PERCENT_RANK() OVER(ORDER BY price DESC)::numeric * 100, 2)
		AS percent_rank
	FROM product
	) res;

-- Save changes
COMMIT;