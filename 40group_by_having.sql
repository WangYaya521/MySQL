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
# 创建订单表 orders
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,  -- 订单ID（主键，自增）
    cust_id INT NOT NULL,                     -- 关联顾客ID
    order_date DATE NOT NULL,                 -- 下单日期
    order_amount DECIMAL(10,2) NOT NULL       -- 订单金额
);

-- 插入与截图完全匹配的测试数据
INSERT INTO orders (order_id, cust_id, order_date, order_amount)
VALUES
(1, 101, '2026-01-05', 199.00),
(2, 101, '2026-01-12', 299.00),
(3, 101, '2026-01-20', 89.00),
(4, 102, '2026-01-08', 699.00),
(5, 102, '2026-01-18', 399.00),
(6, 103, '2026-01-10', 1299.00),
(7, 104, '2026-01-15', 499.00),
(8, 104, '2026-01-22', 899.00),
(9, 105, '2026-01-03', 59.00);

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

