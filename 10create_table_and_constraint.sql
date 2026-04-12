/*创建列表
create table 表名 (
	列名1 数据类型 [列约束],
    列名2 数据类型 [列约束],
    列名3 数据类型 [列约束],
    ...
    列名n 数据类型 [列约束]
);
[数据类型]一般有：int , double , varchar(字符串类型)
[列约束]一般有：primary key(主键) ， not null(非空) , default(指定默认值)
*/

/*添加数据
insert into 表名(列名1 ， 列名2 ，... ，列名n)
values
	(列1值 ， 列2值 ，... ，列n值), -- 添加的第1组数据
    (列1值 ， 列2值 ，... ，列n值), -- 添加的第2组数据
    ...
    (列1值 ， 列2值 ，... ，列n值); -- 添加的第n组数据
*/

use instruction;

create table vendors (
	vend_id int primary key,
    vend_name varchar(50) not null default '苹果科技', -- 在没有提供供应商名称时，自动填充苹果科技
    vend_address varchar(100),
    vend_phone varchar(20)
);

select * from vendors;

# 添加数据
insert into vendors(vend_id , vend_name , vend_address , vend_phone)
values
	(1 , '橘子科技', '安徽省阜阳市' , '18712659903');

insert into vendors(vend_id ,vend_address , vend_phone)
values
	(2 , '安徽省阜阳市' , '18712659903');


/*  修改表结构alter table
	1.添加列ADD
    alter table 表名
    add 列名 数据类型 约束;
    
    2.删除列DROP COLUMN
    alter table 表名
    drop column 列名;
    
    删除表drop table
    drop table 表名;
    
    重命名表rename table
    rename table 原表名 to 新表名;
    
    
*/

alter table vendors
add vend_email varchar(100);

alter table vendors
drop column vend_email;

rename table vendors to vendors2025;

drop table vendors2025;



/*=========================================================================================
约束
[列约束]一般有：primary key(主键) ， not null(非空) , default(指定默认值)
===========================================================================================
*/


use instruction;

select * 
from products
order by prod_price;

# 主键约束primary key========================================================
# 列级主键primary key , 本身包含not null
create table vendors (
	vend_id int primary key, -- 结果从左侧目录中小扳手图标可以观察
    vend_name varchar(50) not null default '苹果科技', -- 在没有提供供应商名称时，自动填充苹果科技
    vend_address varchar(100),
    vend_phone varchar(20)
);

select * from vendors;

drop table vendors;

# 表级主键 ， 在定义完所有字段之后，单独通过primary key 声明 ， 多个字段为主键
create table vendors (
	vend_id int, 
    vend_name varchar(50) not null default '苹果科技', -- 在没有提供供应商名称时，自动填充苹果科技
    vend_address varchar(100),
    vend_phone varchar(20),
    
    primary key (vend_id , vend_name)
);

# 创造表时没有设置主键，使用alter table 添加主键 , add primary key (字段1 ， ...)
create table vendors (
	vend_id int, 
    vend_name varchar(50) not null default '苹果科技', -- 在没有提供供应商名称时，自动填充苹果科技
    vend_address varchar(100),
    vend_phone varchar(20)
);


alter table vendors
add primary key (vend_address);

# 删除主键约束
alter table vendors
drop primary key;


/*外键约束foreign key ， 两个表之间关联，从表的外键关联主表的主键================================
创建表时关联规则
[constraint 外键名称] -- 给外键命名，可选
foreign key (外键)
references 主表的表名（主键）
*/

/*创建表后添加外键
alter table 从表名
add constraint 外键名称
foreign key (从表外键字段)
references 主表名（主表主键字段）
*/

# 创建从表与主表
use instruction;

# 表级外键
# 主表（被引用的表）
create table customers (
	cust_id int primary key,
    cust_name varchar(50) not null,
    cust_contact varchar(50),
    cust_email varchar(50)
);

# 从表(orders表的cust_id 引用customers表中的主键 ，则orders中的cust_id为外键)
create table orders (
	order_num int primary key,
    order_date date not null,
    cust_id int,
    constraint fk_orders_customers -- 给外键命名，可选
	foreign key (cust_id)
	references customers(cust_id)
);

drop table customers;
drop table orders;


# 列级外键  “字段 约束条件 references 主表名（主表的主键）”但是查看的时候是不存在
create table orders (
	order_num int primary key,
    order_date date not null,
    cust_id int references customers (cust_id)
);

# 创建表后添加外键：
create table orders (
	order_num int primary key,
    order_date date not null,
    cust_id int
);
alter table orders
add constraint fk_orders_customers
foreign key (cust_id)
references customers(cust_id);


# 删除外键
alter table orders
drop foreign key fk_orders_customers; -- drop foreign key 外键名称（是外键名称，不是外键字段）







