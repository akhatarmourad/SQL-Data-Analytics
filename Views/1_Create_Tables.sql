drop table if exists tb_customer_data cascade;
drop table if exists tb_product_info cascade;
drop table if exists tb_order_details cascade;
drop view if exists order_summary;

create table if not exists tb_customer_data
(
    cust_id         varchar(10) primary key,
    cust_name       varchar(50) not null,
    phone           bigint,
    email           varchar(50),
    address         varchar(250)
);

create table if not exists tb_product_info
(
    prod_id         varchar(10) primary key,
    prod_name       varchar(50) not null,
    brand           varchar(50) not null,
    price           int
);

create table if not exists tb_order_details
(
    ord_id          bigint primary key,
    prod_id         varchar(10) references tb_product_info(prod_id),
    quantity        int,
    cust_id         varchar(10) references tb_customer_data(cust_id),
    disc_percent    int,
    date            date
);

insert into tb_customer_data values
('C1', 'Mohan Kumar', 9900807090, 'mohan@demo.com', 'Bangalore'),
('C2', 'James Xavier', 8800905544, 'james@demo.com', 'Mumbai'),
('C3', 'Priyanka Verma', 9900223333, 'priyanka@demo.com', 'Chennai'),
('C4', 'Eshal Maryam', 9900822111, 'eshal@demo.com', 'Delhi');

insert into tb_product_info values
('P1', 'Samsung S22', 'Samsung', 800),
('P2', 'Google Pixel 6 Pro', 'Google', 900),
('P3', 'Sony Bravia TV', 'Sony', 600),
('P4', 'Dell XPS 17', 'Dell', 2000),
('P5', 'iPhone 13', 'Apple', 800),
('P6', 'Macbook Pro 16', 'Apple', 5000);

insert into tb_order_details values
(1, 'P1', 2, 'C1', 10, '01-01-2020'),
(2, 'P2', 1, 'C2', 0, '01-01-2020'),
(3, 'P2', 3, 'C3', 20, '02-01-2020'),
(4, 'P3', 1, 'C1', 0, '02-01-2020'),
(5, 'P3', 1, 'C1', 0, '03-01-2020'),
(6, 'P3', 4, 'C1', 25, '04-01-2020'),
(7, 'P3', 1, 'C1', 0, '05-01-2020'),
(8, 'P5', 1, 'C2', 0, '02-01-2020'),
(9, 'P5', 1, 'C3', 0, '03-01-2020'),
(10, 'P6', 1, 'C2', 0, '05-01-2020'),
(11, 'P6', 1, 'C3', 0, '06-01-2020'),
(12, 'P6', 5, 'C1', 30, '07-01-2020');