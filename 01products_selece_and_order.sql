SELECT * FROM instruction.products;

# 切换到这个database才可以进行数据的检索等处理
use instruction;

# 检索单列
select prod_name
from products;

# 检索多列
select prod_name , prod_price , vend_id
from products;

# 检索全部
select *
from products;

# 去重
select distinct vend_id
from products;

# 添加数据
insert into products(prod_id , prod_name , prod_price , vend_id)
values
	(1009 , "台式电脑" , 8999 , 101),
    (1010 , "主机" , 5999 , 101);

# 检索前三行
select *
from products limit 3;

# 从第四行（不包含第四行）开始，检索两行
select prod_id ,prod_name
from products
limit 3 offset 4;

select prod_price
from products;

# -----------------------------------------------------------------------------------

# 排序：select 搭配 order by,默认升序，出现在from之后，limit之前
select prod_price
from products
order by prod_price;

# 多列排序，先按vend_id排序，如果供应商相同，再按prod_price升序排序。
select vend_id , prod_price , prod_name
from products
order by vend_id , prod_price;

/*按位置顺序排序+降序排序（desc）
位置排序：
select vend_id , prod_price , prod_name
vend_id在1号位 ， prod_price在2号位， prod_name在3号位
降序排序：
desc*/
select vend_id , prod_price , prod_name
from products
order by 1 desc , 2 desc;

# 多字段混合排序 ， 先按vend_id降序，再按prod_id升序
select vend_id, prod_name , prod_price
from products
order by 1 desc , 3;