# 切换到这个database才可以进行数据的检索等处理
use instruction;

SELECT * FROM products;

# 过滤数据where ， 从表中筛选出符合条件的数据 ， where在from后，order by前 , 先筛选再排序
# 查询供应商vend_id = 100的产品
select vend_id , prod_name , prod_price
from products
where vend_id = 100
order by prod_price;

/* where 子句操作符
	= , <> , != , > , < , <= , >= , !< , !> 
    between 在范围之间
    is null 为null值
*/
# 查询价格小于399的产品
select prod_name , prod_price , vend_id
from products
where prod_price < 399
order by prod_price;

# 查询蓝牙音箱的信息 , 字符串加英文引号
select prod_name , prod_price ,vend_id
from products
where prod_name = '蓝牙音箱';

# 查询在两个值之间的数据
select *
from products
where prod_price between 299 and 5999
order by 3;

# 查询空值 is null
select prod_name
from products
where prod_price is null;

# null值不参与筛选的查询
select prod_name , vend_id
from products
where vend_id != 100; -- 此时vend_id为null的数据不会被筛选出来

# 筛选条件加入is not null
select prod_name , vend_id
from products
where  vend_id != 101 and vend_id is not null;
