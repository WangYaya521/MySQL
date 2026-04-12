/*统计结果
	avg()--平均值			会自动忽略空值
    count()--统计行数
    max()--最大值
    min()--最小值
    sum()--求和
*/

use instruction;
use products;

# 求取avg(prod_price)
select avg(prod_price) as avg_price
from products;

select avg(prod_price) as avg_price_100
from products
where vend_id = 100;


# count(*) , 统计所有行数 ， count(column) , 统计column行非空的行数
UPDATE products 
SET prod_price = null 
WHERE (prod_id = 1010);
select * from products;

# 统计商品总数量
select count(*) as num_prod
from products;

# 统计价格非空的商品的数量
select count(prod_price) as num_prod_notnull
from products;

# max()
select max(prod_price) as max_price
from products;
# min()
select min(prod_name) as min_name
from products;

# sum
select sum(prod_price) as total_price
from products;

select sum(prod_price) as total_price_102
from products
where vend_id = 102;

# 计算所有供应商商品价格
select vend_id, sum(prod_price) as total_price
from products
group by vend_id;

# 假设每个商品都售卖了两个，计算金额
select sum(prod_price * 2) as sale_price
from products;

# distinct去重，则对不重复的值聚合
update products
set prod_price = 49
where prod_id = 1002;
select * from products;

select avg(distinct prod_price) as avg_price
from products;

select avg(prod_price) as avg_price
from products;


