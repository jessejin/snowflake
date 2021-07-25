use role accountadmin;
create role reader_all;
create role monitor_all;
grant monitor execution, monitor usage on account to role monitor_all;
grant role reader_all to role monitor_all;
grant role monitor_all to role sysadmin;

create role owner_db_1;
grant execute task on account to role owner_db_1;
grant role owner_db_1 to role sysadmin;

create database db_1;
grant ownership on database db_1 to role owner_db_1;


create role reader_db_1;
grant usage, monitor on warehouse compute_wh to role reader_db_1;
grant role reader_db_1 to role owner_db_1;
grant role reader_db_1 to role reader_all;

grant monitor, usage on database db_1 to role reader_db_1;
grant monitor on future tasks in database db_1 to role reader_db_1;
grant usage on future schemas in database db_1 to role reader_db_1;
grant USAGE on future functions in database db_1 to role reader_db_1;
grant USAGE on future procedures in database db_1 to role reader_db_1;
grant select on future tables in database db_1 to role reader_db_1;
grant monitor on future tasks in database db_1 to role reader_db_1;
grant select on future views in database db_1 to role reader_db_1;
grant usage, read on future stages in database db_1 to role reader_db_1;
grant usage on future file formats in database db_1 to role reader_db_1;
grant select on future streams in database db_1 to role reader_db_1;

--to create objects in db, should use the db owner role
use role owner_db_1;
create schema db_1._temp;
grant create table on schema db_1._temp to role reader_db_1;

--clean up
use role accountadmin;
drop schema db_1._temp;
drop database db_1;
drop role reader_db_1;
drop role owner_db_1;
drop role reader_all;
drop role monitor_all;
