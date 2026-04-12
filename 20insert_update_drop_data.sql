/*添加数据
指定列名===========================================
insert into 表名(列名1 ， 列名2 ，... ，列名n)
values
	(列1值 ， 列2值 ，... ，列n值), -- 添加的第1组数据
    (列1值 ， 列2值 ，... ，列n值), -- 添加的第2组数据
    ...
    (列1值 ， 列2值 ，... ，列n值); -- 添加的第n组数据
不指定列名=========================================
insert into 表名(列名1 ， 列名2 ，... ，列名n)
values
	(列1值 ， 列2值 ，... ，列n值), -- 添加的第1组数据
    (列1值 ， 列2值 ，... ，列n值), -- 添加的第2组数据
    ...
    (列1值 ， 列2值 ，... ，列n值); -- 添加的第n组数据


*/

use instruction;

select * from products;

# 指定列名
insert into products(prod_id , prod_name , prod_price , vend_id)
values
	(1011 , '便携投影仪' , 1099 , 103);
    
# 插入部分列
insert into products(prod_id , prod_name  , vend_id)
values
	(1013 , '智能手表' , 103);


# 不指定列名
insert into products
values
	(1012 , '投影仪' , 899 , 103);
    
/*把一张表的数据插入另外一张表，insert和select========================
insert into 目标表（列1 ， ......）
select 列1 ， 列2 ， ...
from 源表名
[where 条件]
*/

# 把products中vend_id为100的产品添加到新表中
# 创建新表
create table hotproducts(                                        -- 更简便的写法：create table hotproducts like products
			prod_id int primary key,
            prod_name varchar(50),
            prod_price double,
            vend_id int
);

create table hotproducts like products;
insert into hotproducts (prod_id , prod_name , prod_price , vend_id)
select prod_id , prod_name , prod_price , vend_id
from products
where vend_id = 100;

select * from  hotproducts;

/*更新数据update===============================================================================
update 表名
set 列名 = 新值，...
where 条件
*/
select * from  products;

# 修改商品1013的vend_id为102
update products
set vend_id = 102
where prod_id = 1013;

# 同时更新多字段
update products
set prod_name = '蓝牙耳机',
	prod_price = 138
where prod_id  = 1013;


/*删除数据=======================================================================
delete from 表名
[where 条件]
*/

# 删除产品1013
delete from products
where prod_id = 1013;

select * 
from  products
where prod_price is null;

delete from products
where prod_price is null;
select * from  products;

# 删除所有行 ， 不加where即可
# 最好使用truncate table 表名
delete from hotproducts;
select * from hotproducts;


