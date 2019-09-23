
-- CREATE TABLE IF NOT EXISTS actor (
-- actor_id smallint(5) NOT NULL PRIMARY KEY,
-- first_name varchar(45) NOT NULL,
-- last_name varchar(45) NOT NULL,
-- last_update timestamp NOT NULL DEFAULT (datetime('now','localtime')))
-- 对first_name创建唯一索引uniq_idx_firstname，对last_name创建普通索引idx_lastname
create unique index uniq_idx_firstname on actor(first_name);
create index idx_lastname on actor(last_name);


-- 唯一索引
-- 唯一索引是不允许其中任何两行具有相同索引值的索引。
-- 当现有数据中存在重复的键值时，大多数数据库不允许将新创建的唯一索引与表一起保存。
-- 数据库还可能防止添加将在表中创建重复键值的新数据。
-- 例如，如果在 employee 表中职员的姓 (lname) 上创建了唯一索引，则任何两个员工都不能同姓。

--创建
CREATE UNIQUE INDEX [IndexName] ON [TableName]([ColumnName],[ColumnName],...)
--删除
DROP INDEX [TableName].[IndexName]


-- MYSQL中强制索引查询使用：FORCE INDEX(indexname);
-- SQLite中强制索引查询使用：INDEXED BY indexname;
select * from salaries
    indexed by idx_emp_no
    where emp_no = 10005;



--聚簇索引创建
-- clustered
-- NONCLUSTERED
CREATE CLUSTERED INDEX [IndexName] ON [TableName]([ColumnName],[ColumnName],...)
--删除
DROP INDEX [TableName].[IndexName]


CREATE INDEX  index_name  ON  table_name(column_name,column_name) include(score)  ---普通索引

CREATE UNIQUE INDEX index_name ON table_name (column_name) ;---非空索引

CREATE PRIMARY KEY INDEX index_name ON table_name (column_name) ;---主键索引

