/* sql子句书写顺序
	select
    from
    inner join on
    where
    group by
    having
    order by
*/



/*==============================================================================================
内联结：等值联结，非等值联结
自联结
左联结
右联结
*/

use instruction;

-- 创建供应商表 vendors
CREATE TABLE vendors (
    vend_id INT PRIMARY KEY,                 -- 供应商ID（主键）
    vend_name VARCHAR(100) NOT NULL,         -- 供应商名称
    vend_address VARCHAR(200),               -- 供应商地址
    vend_phone VARCHAR(20)                   -- 供应商联系电话
);

-- 插入测试数据
INSERT INTO vendors (vend_id, vend_name, vend_address, vend_phone)
VALUES
(100, '科技优品供应商', '北京市海淀区中关村大街1号', '010-12345678'),
(101, '数码配件厂商', '广东省深圳市南山区科技园', '0755-87654321'),
(102, '电竞设备供应商', '上海市浦东新区张江科技园', '021-11223344');

-- 给 products 表添加外键约束（关联 vendors 表）
alter table products
add constraint fk_products_vendors
foreign key (vend_id)
references vendors(vend_id)
on update cascade     -- vendors 中供应商vend_id改变，products中自动跟着改变
on delete restrict;

-- 创建商品价格等级表
CREATE TABLE price_levels (
    level_id INT PRIMARY KEY,       -- 价格等级ID（主键）
    level_name VARCHAR(20),         -- 等级名称
    min_price DECIMAL(8,2),         -- 价格区间下限
    max_price DECIMAL(8,2)          -- 价格区间上限
);

-- 插入价格等级数据
INSERT INTO price_levels VALUES
(1, '低价商品', 0, 100),
(2, '中价商品', 100, 500),
(3, '高价商品', 500, 3000),
(4, '奢品商品', 3000, 10000);

/*
alter table products
drop foreign key fk_products_vendors;
*/


/* 内联结（inner join）=============================================================
返回两表匹配行的联结，都叫内联结，不管关联条件是等号还是其他运算符
		select 字段1 ， 字段2 ， ...
		from 联结表1
		inner join 联结表2      -- inner 可以省略
			on 关联条件
*/

# 等值联结（相当于把两个表拼接起来作为临时结果集）：1.多个表出现在from子句中；2.选取相同字段名用=作为关联条件
-- 查询所有产品对应的供应商名称，产品名称及价格
select vend_name , prod_name , prod_price
from vendors , products
where vendors.vend_id = products.vend_id
order by prod_price;

# 等价于
select prod_name , vend_name
from vendors
inner join products
	on products.vend_id = vendors.vend_id;

select products.prod_name , vendors.vend_name
from products
join vendors
	on products.vend_id = vendors.vend_id;

# 非等值联结
select prod_name , level_id , level_name
from products
join price_levels
	on products.prod_price between price_levels.min_price and price_levels.max_price
order by level_id;

# 联结多个表，查询订购1007的所有顾客的信息,两两之间通过相同字段链接
/*用子查询的方式
select *
from customers
where cust_id in (select cust_id
					from orders
                    where order_id in (select order_id
										from orderItems
                                        where prod_id = 1007));
*/
# join on
select customers.cust_id , customers.cust_name , customers.cust_phone
from customers
join orders on orders.cust_id = customers.cust_id
join orderItems on orderItems.order_id = orders.order_id
where prod_id = 1007;

# 旧式写法
select customers.cust_id , customers.cust_name , customers.cust_phone , customers.cust_address
from customers , orders , orderItems
where
	customers.cust_id = orders.cust_id
    and orders.order_id = orderItems.order_id
    and orderItems.prod_id = 1007;

# inner join on 与子查询结合使用
-- 查询2026年1月有下单的用户姓名，电话，订单号
select customers.cust_name , customers.cust_phone , linshi_orders.order_id
from customers
join (
	select order_id , cust_id
	from orders
    where order_date between '2026-01-01' and '2026-01-31') as linshi_orders -- 在这里需要给临时结果命名，否则无法查询到外层的orders table
on linshi_orders.cust_id = customers.cust_id;

select customers.cust_name , customers.cust_phone , orders.order_id
from customers
join orders
	on orders.cust_id = customers.cust_id
where orders.order_date between '2026-01-01' and '2026-01-15';


/*自联结===========================================================================================
	1.联结对象必须是同一个已存在的表
	2.必须为表定义不同的别名
	3.连接条件必须是关联同一张表内的行
自联结依赖于内联结，左联结与右联结
update products
set prod_price = 99
where prod_name = '无线鼠标';
*/

# 找出同供应商比‘无线鼠标’更贵的产品
-- 无线鼠标价格

select prod_price , vend_id
from products
where prod_name = '无线鼠标';

select p1.prod_name , p1.prod_price
from products p1
join products p2
on p1.prod_price > p2.prod_price
	and p1.vend_id = p2.vend_id
where p2.prod_name = '无线鼠标';


/*外联结===========================================================================================
	1.左联结left join，保留左表，右边不存在的值填充null
	2.右联结right join，保留右表，左边不存在的值填充null
*/

# 为顾客表添加一行没有订单的顾客
insert into customers(cust_id,cust_name,cust_phone,cust_email,cust_address)
values (106 , '周八' , '13802849473' , 'zhouba@example.com' , '成都市锦江区' );

select * from customers;

# from后面跟左表 ， join 后面跟右表
select customers.cust_id , customers.cust_name , count(orders.cust_id) as order_total
from customers
left join orders
on orders.cust_id = customers.cust_id
group by customers.cust_id , customers.cust_name
order by order_total desc;

# 统计所有客户订单及订单信息--先有顾客，后有订单，后有订单明细
select customers.cust_id , customers.cust_name , orderItems.order_id , orderItems.prod_id , orderItems.quantity
from customers
left join orders
		on orders.cust_id = customers.cust_id
left join orderItems
		on orders.order_id = orderItems.order_id
order by customers.cust_id;



















