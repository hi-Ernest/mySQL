
-- 选修c2课程中成绩最高的学生
select S from SC where C# = "c2" and grade >= all
    (select grade from SC where C# = "c2")

-- 查询入职员工时间排名倒数第三的员工所有信息
-- LIMIT m,n : 表示从第m+1条开始，取n条数据；
-- LIMIT n ： 表示从第0条开始，取n条数据，是limit(0,n)的缩写。
select * from employees order by hire_date desc limit 2,1;




-- 查找各个部门当前(to_date='9999-01-01')领导当前薪水详情以及其对应部门编号dept_no
-- CREATE TABLE `dept_manager` (
-- `dept_no` char(4) NOT NULL,
-- `emp_no` int(11) NOT NULL,
-- `from_date` date NOT NULL,
-- `to_date` date NOT NULL,
-- PRIMARY KEY (`emp_no`,`dept_no`));
-- CREATE TABLE `salaries` (
-- `emp_no` int(11) NOT NULL,
-- `salary` int(11) NOT NULL,
-- `from_date` date NOT NULL,
-- `to_date` date NOT NULL,
-- PRIMARY KEY (`emp_no`,`from_date`));
select salaries.emp_no, salaries.salary, salaries.from_date, salaries.to_date, dept_manager.dept_no
    from salaries inner join dept_manager on salaries.emp_no = dept_manager.emp_no and
    salaries.to_date = '9999-01-01' and
    dept_manager.to_date = '9999-01-01';


-- INNER JOIN 两边表同时有对应的数据，即任何一边缺失数据就不显示。
-- LEFT JOIN 会读取左边数据表的全部数据，即便右边表无对应数据。
-- RIGHT JOIN 会读取右边数据表的全部数据，即便左边表无对应数据。

-- 查找所有员工的last_name和first_name以及对应部门编号dept_no，也包括展示没有分配具体部门的员工
select employees.last_name, employees.first_name, dept_emp.dept_no
    from employees left join dept_emp
        on employees.emp_no = dept_emp.emp_no;


--注意on与where有什么区别，两个表连接时用on，在使用left  jion时，on和where条件的区别如下：
-- 1、on条件是在生成临时表时使用的条件，它不管on中的条件是否为真，都会返回左边表中的记录。
-- 2、where条件是在临时表生成好后，再对临时表进行过滤的条件。这时已经没有left  join的含义（必须返回左边表的记录）了，条件不为真的就全部过滤掉。



-- 查找薪水涨幅超过15次的员工号emp_no以及其对应的涨幅次数t
select emp_no,count(emp_no) as t
    from salaries
        group by emp_no having t > 15;



-- 获取所有非manager的员工emp_no
select a.emp_no
    from employees a left join dept_manager b
    on a.emp_no = b.emp_no
    where b.emp_no is null;


-- 统计出当前各个title类型对应的员工当前（to_date='9999-01-01'）薪水对应的平均工资。结果给出title以及平均工资avg。
select t.title, avg(s.salary) as 'avg'
    from titles t inner join salaries s
    where t.emp_no = s.emp_no
    and t.to_date = '9999-01-01'
    and s.to_date = '9999-01-01'
    group by t.title


-- 获取当前（to_date='9999-01-01'）薪水第二多的员工的emp_no以及其对应的薪水salary
select emp_no, salary
    from salaries s
    where s.to_date = '9999-01-01'
    order by salary desc limit 1,1;

-- 查找当前薪水(to_date='9999-01-01')排名第二多的员工编号emp_no、薪水salary、last_name以及first_name，不准使用order by
select e.emp_no, max(s.salary) as salary, e.last_name, e.first_name
    from employees e inner join salaries s
    on e.emp_no = s.emp_no
    where to_date='9999-01-01'
    and salary not in (select max(salary) from salaries where to_date='9999-01-01');




-- 查找所有员工的last_name和first_name以及对应的dept_name，也包括暂时没有分配部门的员工
select e.last_name, e.first_name, d.dept_name
    from employees e
    left join dept_emp de
    on e.emp_no = de.emp_no
    left join departments d
    on de.dept_no = d.dept_no;




-- 查找员工编号emp_no为10001其自入职以来的薪水salary涨幅值growth
-- CREATE TABLE `salaries` (
-- `emp_no` int(11) NOT NULL,
-- `salary` int(11) NOT NULL,
-- `from_date` date NOT NULL,
-- `to_date` date NOT NULL,
-- PRIMARY KEY (`emp_no`,`from_date`));
select (
    select salary from salaries where emp_no = 10001 order by to_date desc limit 1)
    -
    (select salary from salaries where emp_no = 10001 order by to_date limit 1)
as growth;