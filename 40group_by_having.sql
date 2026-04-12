SELECT * FROM instruction.products;


# group by 分组 ，select里面非聚合的列必须全部都在group by之后
select vend_id , count(*) as num_prod
from products
group by vend_id;

# 组合分组
update products
set prod_name = "机械键盘"
where prod_name = '蓝牙音箱';

select vend_id , prod_name , count(*) as num_prod
from products
group by vend_id , prod_name;

select vend_id , prod_price * 0.8 as discount_price , count(*) as num_prod
from products
group by vend_id , prod_price * 0.8;


# having过滤分组，对分组后的数据进行筛选 与group by 搭配使用
use instruction;
-- 创建订单表 orders
CREATE TABLE orders (
    cust_id INT not null,
    order_date DATE NOT NULL,
    order_amount double NOT NULL
);

INSERT INTO orders (cust_id, order_date, order_amount)
VALUES
    (101, '2026-01-15', 199.99),
    (101, '2026-01-18', 520.00),
    (101, '2026-01-22', 88.50),
    (102, '2026-01-15', 1299.00),
    (102, '2026-01-19', 350.75),
    (103, '2026-01-12', 66.00),
    (103, '2026-01-18', 999.99),
    (103, '2026-01-25', 420.30),
    (104, '2026-01-08', 1500.50),
    (109, '2026-01-15', 77.20);

select * from orders;

# 统计至少有两个订单的客户
select cust_id , count(*) as num_cust
from orders
group by cust_id
having count(*) > 2;


/* sql子句书写顺序
	select
    from
    where
    group by
    having
    order by
*/

