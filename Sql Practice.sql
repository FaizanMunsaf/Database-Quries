create database practice
use practice
create table emp(empid int unique not null,empname varchar(50) not null,email varchar(50)not null,Desgination varchar(50)not null );
select *from emp,department
insert into emp values(1,'Faizan','faizan@gmail.com','Manager');
insert into emp values(2,'umair','umair@gmail.com','Assistant Manager');
insert into emp values(3,'khubaib','khubaib@gmail.com','I-T Incharge');
insert into emp values(4,'Farhan','farhan@gmail.com','Computer Operator');
insert into emp values(5,'Farha','farha@gmail.com','Assistant Operator');
create table department(dpt_id int unique not null,dpt_name varchar(50) not null,dpt_salary int not null,emp_id int unique not null );
insert into department values(1,'CS',10000,1);
insert into department values(43,'SE',20000,4); 
insert into department values(56,'IT',30000,3);
insert into department values(89,'DA',40000,2);
insert into department values(99,'CS',50000,7);

--INNER JOIN-- 
select *from emp as A
inner join department as B
on A.empid=B.empid
--Common Values or id taken in inner joins--

--Left JOIN--
select *from emp as A
left join department as B
on A.empid=B.empid
--Left table every extra row also visible but Right Table will not --

--Right JOIN--
select *from emp as A
Right join department as B
on A.empid=B.empid 
--Right table every extra row also visible but Left Table will not --

--Full Outer JOIN--
select *from emp as A
Full outer join department as B
on A.empid=B.empid 
--fULL OUTER Join shows both the table data--

--Having--
select dpt_name, sum(dpt_salary) as Total_SaIary
from department
group by dpt_name
having dpt_name in ('CS');
--==================================--------
select dpt_name, sum(dpt_salary) as Total_SaIary
from department
group by dpt_name
having sum(dpt_salary) > 20000;
--==================================--------
select dpt_name, sum(dpt_salary) as Total_SaIary
from department
group by dpt_name
having sum(dpt_salary) >= 20000;

 --Where --
select dpt_name, sum(dpt_salary) as Total_SaIary
from department
where dpt_name in ('CS')
group by dpt_name 
--We can't use aggregate function with where--

-- Having and where both in single query--
select dpt_name, sum(dpt_salary) as Total_SaIary
from department
where dpt_name in ('CS','IT')
group by dpt_name
having sum(dpt_salary) >= 20000;

-- not in operator--
select dpt_name, sum(dpt_salary) as Total_SaIary
from department
where dpt_name not in ('CS','IT')
group by dpt_name
having sum(dpt_salary) >= 20000;
--having is slower than where and if u need good performance you should use where--


--between--
select *from department where dpt_salary between 20000 and 40000

--Top--
select Top 3 *from department

--Percent--
select Top 40 percent *from department

--Distinct--
select distinct dpt_name from department

--in--
select *from department where dpt_name in('CS')

--Sub Query--
select *from department where dpt_id in
(select dpt_id from department where dpt_salary > 10000); 
/*=> Only one column we can specify in sub query
=> Firstly inner Query Run after that outter Query Run*/

--==================================--------
--Update Sub Query--  --add 2000 in salary--
update department set dpt_salary=dpt_salary +2000
where dpt_id in
(select dpt_id from department where dpt_name = 'CS'); 
--for checking update sub query--
select *from department

--==================================--------
--Deletion Sub Query-- 
delete from department
where dpt_id in
(select dpt_id from department where dpt_name = 'DA'); 

--==================================--------
--Multiple table Sub Query-- 
select *from emp where empid in
(select dpt_id from department where dpt_name='CS'); 

--------------------------------------------------
--Order By--
select *from department where dpt_id in
(select dpt_id from department where dpt_salary > 10000)
order by dpt_id desc;
--Using Descending Order for desc and for aescending order asc--
--we can't us this into views and subqueries etc--




--Self Join--
create table emp1(emp_id int,emp_name nvarchar(50),Manager_id nvarchar(50))
insert into emp1 values(1,'Faizan',2);
insert into emp1 values(2,'Farhan',3);
insert into emp1 values(3,'Umair',1);
insert into emp1 values(4,'Khubaib',5);
insert into emp1 values(5,'Ahmed',6);
insert into emp1 values(6,'Umais',4); /*truncate table emp1*/
--Self Join Start --
select A.emp_name as Manager, B.emp_name as Employee 
from emp1 as A
inner join emp1 as B
on A.Manager_id=B.emp_id;




/*===========================================
Views (Virtual Tables)
=> Insert with views
=> Update with views
=> Delete with views
===========================================*/
create view faizan
as
select *from emp as A
inner join department as B
on A.empid=B.emp_id;
--Next View-- --Use one id from both tables-- --Hide Column level security--
create view faizan1
as
select A.*, B.dpt_name, B.dpt_salary, B.dpt_id from emp as A
inner join department as B
on A.empid=B.emp_id;
--Hide Row level security--
create view faizan2
as
select A.*, B.dpt_name, B.dpt_salary, B.dpt_id from emp as A
inner join department as B
on A.empid=B.emp_id
where dpt_name = 'CS';
--Lets check views--
select *from faizan
select *from faizan1
select *from faizan2
--Alter View--
alter view faizan2
as
select A.*, B.dpt_name, B.dpt_salary, B.dpt_id from emp as A
inner join department as B
on A.empid=B.emp_id
where dpt_name = 'CS' or dpt_name='IT';
--Apply insert Command in views--
create view faiz
as
select *from emp
--Start Insert operation in view from here in faiz view--
insert into faiz values(6,'ahmad','ahmad@gmail.com','Branch Manager');
select *from faiz
--as like this update and delete function also applicable to use in it--

--Sp Help Text--
sp_helptext faizan1







/* ============================================
Scalar-Valued Function
============================================*/
create function show()
returns varchar(100)
as
begin
 return 'welcome'
end
-- For Calling-- 
select dbo.show();

--Next function-- --Parameterized--
create function parameter(@num as int)
returns int
as
begin
 return (@num*@num)
end
-- For Calling-- 
select dbo.parameter(2);
--Next function-- --Multi Parameterized--
create function addittion(@num as int,@num2 as int)
returns int
as
begin
 return (@num + @num2)
end
-- For Calling-- 
select dbo.addittion(2,5);

--Alter Function--
alter function parameter(@num as int)
returns int
as
begin
 return (@num*@num * @num)
end
--for if Function & declare variable--
create function forvote(@age as int)
returns varchar(100)
as
begin
 declare @str varchar(100)
 if @age>=18
 begin
 set @str = 'you are eligible to vote'
 end
 else
 begin
 set @str = 'You Are not Eligible to vote'
 end
 return @str
end
-- For Calling-- 
select dbo.forvote(20);

--Scalar function Can call other function--
create function getmydate()
returns datetime
as begin
return getdate()
end
-- For Calling-- 
select dbo.getmydate();



/* ============================================
Aggregate-Valued Function
============================================*/
select *from department

--Sum Function--
select sum(dpt_salary) as Total_Salary from department
--Max Function--
select max(dpt_salary) as Maximum_Salary from department
--Min Function--
select min(dpt_salary) as Min_Salary from department
--Average Function--
select avg(dpt_salary) as Average_Salary from department
--Count Function--
select count(dpt_salary) as count_row_Salary from department



/* ============================================
Inline Table-Valued Function
============================================*/
create function tabular()
returns table
as
return (select * from department)

--for check--
select * from tabular();
 
--we can apply conditions in its prenthasis too--

/* ============================================
Constraint in sql server
============================================*/