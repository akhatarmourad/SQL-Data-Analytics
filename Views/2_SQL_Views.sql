-- Select all customers 
select * from tb_customer_data;

-- Select all products
select * from tb_product_info;

-- Select all orders
select * from tb_order_details;

-- Select orders details
CREATE VIEW order_details AS
SELECT o.ord_id, o.date, p.prod_name, c.cust_name,
	(p.price * o.quantity) - ((p.price - o.quantity) * o.disc_percent::float / 100) as total_cost
	FROM tb_order_details o
	JOIN tb_customer_data c ON o.cust_id = c.cust_id
	JOIN tb_product_info p ON o.prod_id = p.prod_id;

SELECT * FROM order_details;


