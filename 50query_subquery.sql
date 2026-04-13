/*
简单查询
	从单个数据库表中检索数据的单条、无嵌套的 SELECT 语句	
		1. 数据源：仅涉及一个表
		2. 结构：无嵌套子查询
		3. 复杂度：基础、直接
        
查询 (query)
	广义上，任何 SQL 语句都可称为查询；通常特指用于数据检索的 SELECT 语句	
		1. 广义：涵盖增删改查 (CRUD) 所有 SQL 语句
		2. 狭义：专指数据读取操作
        
子查询 (subquery)
	嵌套在其他查询（如 SELECT、UPDATE、DELETE）中的查询，其结果可作为外部查询的输入	
		1. 结构：嵌套存在
		2. 功能：结果集可作为外部查询的条件或数据源
		3. 灵活性：可实现复杂的多表关联或逻辑判断
*/

use instruction;

CREATE TABLE orderItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,  -- 订单商品明细 ID
    order_id INT NOT NULL,                         -- 订单 ID
    prod_id INT NOT NULL,                          -- 商品 ID
    quantity INT NOT NULL DEFAULT 1,               -- 商品数量，默认 1
    item_price DECIMAL(10,2) NOT NULL,             -- 商品单价（下单时的快照价）
	foreign key (order_id) references orders (order_id),
    foreign key (prod_id) references products (prod_id)
);

INSERT INTO orderItems (order_id, prod_id, quantity, item_price) -- 创建数据时，对order_id的插入必须是从表orders中已有的，否则报错
VALUES
(1, 1007, 2, 89.00),   -- 订单1包含商品1007（无线充电器），2件，单价89
(2, 1001, 1, 5999.00), -- 订单2包含商品1001（笔记本电脑），1件，单价5999
(3, 1003, 1, 299.00),  -- 订单3包含商品1003（机械键盘），1件，单价299
(4, 1007, 3, 89.00);   -- 订单4包含商品1007（无线充电器），3件，单价89


CREATE TABLE customers (
    cust_id INT PRIMARY KEY AUTO_INCREMENT, -- 顾客ID
    cust_name VARCHAR(50) NOT NULL,         -- 顾客姓名
    cust_phone VARCHAR(20),                -- 顾客手机号
    cust_email VARCHAR(50),                -- 顾客邮箱
    cust_address VARCHAR(100)              -- 顾客地址
);

INSERT INTO customers (cust_id, cust_name, cust_phone, cust_email, cust_address)
VALUES
(101, '张三', '13800138001', 'zhangsan@example.com', '北京市朝阳区'),
(102, '李四', '13900139002', 'lisi@example.com', '上海市浦东新区'),
(103, '王五', '13700137003', 'wangwu@example.com', '广州市天河区'),
(104, '赵六', '13600136004', 'zhaoliu@example.com', '深圳市南山区'),
(105, '孙七', '13500135005', 'sunqi@example.com', '杭州市西湖区');

select * from customers;

alter table orders
add constraint fk_orders_customers
foreign key (cust_id)
references customers(cust_id);

/*
子查询==================================================================================================
*/

# 查询包含商品1007的所有顾客信息
# 1.先查询包含1007商品的所有订单编号
select order_id
from orderItems
where prod_id = 1007;   

# 2.查询订单号为1和3的cust_id
select cust_id
from orders
where order_id = 1 or order_id = 4;

# 3.查询cust_id为101 102 的顾客信息
select *
from customers
where cust_id in (101 , 102);

/*
子查询由内向外查询==================================================================================================
*/

select *
from customers
where cust_id in (select cust_id
					from orders
                    where order_id in (select order_id
										from orderItems
                                        where prod_id = 1007));


# 计算字段：查询过程中出现的不存在表中的列，比如count
# 统计每个顾客的订单总数
select cust_id , count(*) as num_order
from orders
group by cust_id;

select cust_id ,
		cust_name , 
		(select count(*)
        from orders
        where orders.cust_id = customers.cust_id) as orders
from customers
order by cust_id;
