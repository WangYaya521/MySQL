/*
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


/* 内联结（inner join）
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







