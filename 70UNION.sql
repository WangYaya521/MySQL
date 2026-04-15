/*union 
对表做多条查询时，对结果进行上下拼接，必须返回相同数量的列
并且对应的数据类型要兼容，字段名可以不同，以第一个select的字段为准
	select ...
	...
	union
	select ...
	...
*/
use instruction;

# 对同一个表进行查询=====================================
# 查询来自上海和北京的用户
select cust_name , cust_phone , cust_email , cust_address
from customers
where cust_address like '北京%'
union
select cust_name , cust_phone , cust_email , cust_address
from customers
where cust_address like '上海%';

-- 等价于or
select cust_name , cust_phone , cust_email , cust_address
from customers
where cust_address like '北京%' or cust_address like '上海%';

# 不同表查询结果合并========================================
# 整合完整的联系人列表，包括顾客姓名电话和供应商姓名联系方式
select 
	cust_id as id,
	cust_name as name,
	cust_phone as phone,
    '顾客' as type
from customers
union 
select 
	vend_id , 
	vend_name , 
    vend_phone,
    '供应商'
from vendors;


/*
union会去重
union all不会去重
*/

# 对比商品的成交价（orderItems）和定价(products) ， 多次成交的商品也要显示出
select 
	prod_id as id,
    prod_name as name,
    prod_price as price, -- int
    '定价' as type
from products
union all
select 
	orderItems.prod_id,
    products.prod_name,
    orderItems.item_price, -- double , int类型会转化为double，向上兼容，int < decimal < float < double
    '成交价' as type
from orderItems
join products
on orderItems.prod_id = products.prod_id;











































