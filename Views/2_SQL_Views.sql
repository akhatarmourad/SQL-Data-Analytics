-- Select all customers 
select * from tb_customer_data;

-- Select all products
select * from tb_product_info;

-- Select all orders
select * from tb_order_details;

-- Select orders details
CREATE OR REPLACE VIEW order_details AS
SELECT o.ord_id, o.date, p.prod_name, c.cust_name,
	(p.price * o.quantity) - ((p.price - o.quantity) * o.disc_percent::float / 100) as total_cost
	FROM tb_order_details o
	JOIN tb_customer_data c ON o.cust_id = c.cust_id
	JOIN tb_product_info p ON o.prod_id = p.prod_id;

SELECT * FROM order_details;

-- Rename Columns names & View name
ALTER VIEW order_details RENAME COLUMN ord_id TO order_id;
ALTER VIEW order_details RENAME COLUMN prod_name TO product_name;
ALTER VIEW order_details RENAME COLUMN cust_name TO customer_name;

ALTER VIEW order_details RENAME TO order_details_view;

SELECT * FROM order_details_view;

-- Delete a view
DROP VIEW order_details_view;

-- Updatable Views
CREATE OR REPLACE VIEW expensive_products AS
SELECT * FROM tb_product_info p WHERE p.price > 1000;

SELECT * FROM expensive_products;

UPDATE expensive_products SET prod_name = 'Dell Latitude XPS 17', brand = 'Dell Technologies' WHERE prod_id = 'P4';

SELECT * FROM expensive_products;

-- WITH OPTION CHECK 
CREATE OR REPLACE VIEW apple_products AS
SELECT * FROM tb_product_info p WHERE p.brand = 'Apple'
WITH OPTION CHECK;

SELECT * FROM apple_products;