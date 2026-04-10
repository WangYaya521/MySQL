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
===========================================================================================
*/


use instruction;
