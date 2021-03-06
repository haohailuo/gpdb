-- @description : delete tuples from  Updatable AO tables 
-- 

-- Create AO tables 
DROP TABLE if exists sto_uao_del_1_del;
CREATE TABLE sto_uao_del_1_del (
          col_int int,
          col_text text,
          col_numeric numeric
          ) with(appendonly=true) DISTRIBUTED RANDOMLY;


SELECT 1 AS VisimapPresent  FROM pg_appendonly WHERE visimapidxid is not NULL AND visimapidxid is not NULL AND relid=(SELECT oid FROM pg_class WHERE relname='sto_uao_del_1_del');

Create index sto_uao_del_1_del_int_idx1 on sto_uao_del_1_del(col_int);

insert into sto_uao_del_1_del values(1,'val1',100);
insert into sto_uao_del_1_del values(2,'val2',200);
insert into sto_uao_del_1_del values(3,'val3',300);
select *  from sto_uao_del_1_del order by col_int;
delete from sto_uao_del_1_del where col_int = 1;
select *  from sto_uao_del_1_del order by col_int;
select count(*) AS only_visi_tups  from sto_uao_del_1_del ;
set gp_select_invisible = true;
select count(*) AS invisi_and_visi_tups  from sto_uao_del_1_del ;

set gp_select_invisible = false;

-- Create table with all data_types 

-- Create table with constriants
Drop table if exists sto_uao_del_2_del;
CREATE TABLE sto_uao_del_2_del(
          col_text text DEFAULT 'text',
          col_numeric numeric
          CONSTRAINT tbl_chk_con1 CHECK (col_numeric < 250)
          ) with(appendonly=true) DISTRIBUTED by(col_text);

SELECT 1  AS VisimapPresent FROM pg_appendonly WHERE visimapidxid is not NULL AND visimapidxid is not NULL AND relid=(SELECT oid FROM pg_class WHERE relname='sto_uao_del_2_del');
insert into sto_uao_del_2_del values ('0_zero',20);
insert into sto_uao_del_2_del values ('1_one',10);
insert into sto_uao_del_2_del values ('2_two',25);
select count(*) from sto_uao_del_2_del;
delete from sto_uao_del_2_del where col_text = '1_one';
select count(*) from sto_uao_del_2_del;
set gp_select_invisible = true;
select count(*) from sto_uao_del_2_del;


--Update table in user created scehma
set gp_select_invisible = false;
Drop schema if exists uao_del_schema1 cascade;
Create schema uao_del_schema1;

CREATE TABLE uao_del_schema1.sto_uao_del_3_del(
          stud_id int,
          stud_name varchar(20)
          ) with(appendonly=true) DISTRIBUTED by(stud_id);

SELECT 1  AS VisimapPresent FROM pg_appendonly WHERE visimapidxid is not NULL AND visimapidxid is not NULL AND relid=(SELECT oid FROM pg_class WHERE relname='sto_uao_del_3_del');
Insert into uao_del_schema1.sto_uao_del_3_del values(1,'name1'), (2,'name2'),(3,'name3');
select * from uao_del_schema1.sto_uao_del_3_del order by 1;
delete from uao_del_schema1.sto_uao_del_3_del where stud_id=1;
select * from uao_del_schema1.sto_uao_del_3_del order by 1;
set gp_select_invisible = true;
select * from uao_del_schema1.sto_uao_del_3_del order by 1;

set gp_select_invisible = false;

-- Truncate


Drop table if exists sto_uao_del_7_del;
CREATE TABLE sto_uao_del_7_del  (
    did integer,
    name varchar(40),
    CONSTRAINT con1 CHECK (did > 99 AND name <> '')
    ) with(appendonly=true) DISTRIBUTED RANDOMLY;


insert into sto_uao_del_7_del  values (100,'name_1');
insert into sto_uao_del_7_del  values (200,'name_2');
insert into sto_uao_del_7_del  values (300,'name_3');

select count(*) from sto_uao_del_7_del ;
delete from sto_uao_del_7_del where did = 100;
select count(*) from sto_uao_del_7_del ;
set gp_select_invisible = true;
select count(*) from sto_uao_del_7_del;
Truncate sto_uao_del_7_del;
select count(*) from sto_uao_del_7_del;
set gp_select_invisible = false;
