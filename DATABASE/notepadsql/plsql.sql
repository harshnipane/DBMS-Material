


______________________________________________________STOREDPROCEDURE___________________________________


delimiter //
create procedure insert_dept(did int, dname varchar(20), dloc varchar(20))
BEGIN
insert into dept values (did,dname,dloc);
end//
delimiter;



delimiter //
create procedure netsal (eid int, out remark varchar(20))
BEGIN
DECLARE vsal float(9,2) default 0;
select sal +ifnull(comm,0) into vsal from emp
where empno = eid;
if vsal <1000 THEN
set remark ='less';
elseif vsal < 2000 THEN
set remark = 'ok';
elseif vsal < 3000 THEN
set remark = 'good';
ELSE
set remark = 'excellent';
end if;
select vsal, remark;
end//
delimiter;


_________________________________________________CURSORRRRRRRRRRRR_____________________________________________
delimiter //
create procedure displayallemp()
BEGIN
    DECLARE VSET , VEMPNO INT default 0;
	DECLARE VNAME VARCHAR(20);

	DECLARE EMPCUR CURSOR FOR SELECT EMPNO, ENAME FROM EMP;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET VSET = 1;
	OPEN EMPCUR;
	LABLEL : LOOP	
		FETCH EMPCUR INTO VEMPNO, VNAME;
		IF VSET = 1 THEN
		LEAVE LABLEL;
		END IF;
		SELECT VEMPNO, VNAME;
		END LOOP;
		CLOSE EMPCUR;
		
end//
DELIMITER;	


_______________display all emp with sal < avg sal____________

delimiter //
create procedure displaysal()
BEGIN
    DECLARE VSET , VEMPNO, vdeptno INT default 0;
	DECLARE VNAME, vjob varchar(20);	
	declare vsal, vavgsal float (9,2);
	DECLARE EMPCUR CURSOR FOR SELECT EMPNO, ENAME, job, deptno FROM EMP;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET VSET = 1;
	OPEN EMPCUR;
	LABLEL : LOOP	
		FETCH EMPCUR INTO VEMPNO, VNAME,vjob, vdeptno;
		IF VSET = 1 THEN
		LEAVE LABLEL;
		END IF;
		select avg(sal) into vavgsal
		from emp
		where deptno = vdeptno;
		if vsal < vavgsal THEN
		select vempno, vename, vjon, vsal, vdeptno;
		end if;
		END LOOP;
		CLOSE EMPCUR;
		
end//
DELIMITER ;




________________________________________________FUNCTIONS_________________________________________________

generate email 

delimiter //

create function generatemail(fename varchar(20),fjob varchar(20)) returns varchar(30)
BEGIN
	declare vemail varchar(30);
	set vemail = concat(substr(fename,3,4),'.',left(fjob,3),'@mycompany.com');
	return vemail;
end//

delimiter ;	

select empno,ename,job, generateemail(ename,job) from emp;



________________________________________________TRIGGERS__________________________________________________


create table dept_audit(
did int,
dname varchar(20),
old_dname varchar(20),
new_loc varchar(20),
old_loc varchar(20),
username varchar(20),
chng_date date);


delimiter //
create trigger update_dept
before update
on dept
for each ROW	
	insert into dept_audit values
	(old.deptno, new.dname, old.dname, new.loc,  old.loc,  user(),curdate());	
end//
delimiter ;	



update table dept_audit
 add action varchar(20);
 

delimiter //
create trigger insert_dept
before insert
on dept
for each ROW	
	insert into dept_audit values
	(new.deptno, new.dname, null, new.loc,  null,  user(),curdate(),'insert');	
end//
delimiter ;	


delimiter //
create trigger delete_dept
before delete
on dept
for each ROW	
	insert into dept_audit values
	(old.deptno, null , old.dname, null , old.loc,  user(),curdate(),'delete');	
end//
delimiter ;



____________________________________________Exception Handling_______________________________________________




delimiter //
create procedure insertexec(did int, edname varchar(20), edloc varchar(20))
BEGIN
declare exit HANDLER for sqlexception select 'error occured';
insert into dept values(did,edname,edloc);
select did,edname,edloc,'duplicate entry';
end//
delimiter ;







____________________________________________PLSQL ASSIGNMENT__________________________________________________
--1

delimiter //
create function ctc_main(femp_num int) returns float(9,2)
BEGIN
declare ctc float(9,2);
declare expr int;
declare total_sal float(9,2);

select floor(datediff(curdate(),hiredate)/365),(0.15*sal + 0.20*sal + 0.8*sal) into expr,total_sal 
from emp where empno = femp_num;

if expr > 40 then set ctc = total_sal;
elseif expr >41 then set ctc = (0.10 * total_sal) + total_sal;
elseif expr >42 then set ctc = (0.20 * total_sal) + total_sal;
else set ctc = (0.30 * total_sal) + total_sal;
end if;
return ctc;
end//

delimiter ;




--2

delimiter //
create procedure emp_info_main(fid int, out remark varchar(20))
BEGIN
declare fename varchar(20);
declare fdname, fjob varchar(20);
declare avg_sal float(9,2);
declare salary float(9,2);

select emp.ename, dept.dname,emp.job,emp.sal, a.avgs into fename, fdname, fjob, salary, avg_sal
from emp join dept 
on emp.deptno = dept.deptno
join
(select emp.deptno, avg(emp.sal) as avgs
from emp join dept 
on emp.deptno = dept.deptno
group by deptno) as a 
on emp.deptno = a.deptno
where empno = fid;

if salary < avg_sal then set remark = 'Lesser';
elseif salary > avg_sal then set remark = 'Greater';
else set remark = 'Equal';
end if;
select fename, fdname, fjob, remark;
end//

delimiter ;





--5

CREATE TABLE EMP_BACK
       (EMPNO INT,
        ENAME varchar(10),
        JOB varchar(9),
        MGR INT,
        HIREDATE DATE,
        SAL DECIMAL(7, 2),
        COMM DECIMAL(7, 2),
        DEPTNO INT);
		


delimiter //
create procedure update_salary(fenum int)
begin 
declare oldsal float(9,0);
declare expr int;
declare newsal float(9,0);

select sal into oldsal from emp
where empno = fenum;

select floor(datediff(curdate(),hiredate)/365) into expr
from emp where empno = fenum;

insert into emp_back (empno, sal) values (fenum,oldsal);

if expr < 2 then
set newsal = oldsal;
elseif expr between 2 and 5 then
set newsal = 1.20 * oldsal;
elseif expr > 25 then
set newsal = 1.25* oldsal;
end if;

update emp
set sal = newsal
where empno = fenum;
end//
delimiter ;


________________OR_______________________


delimiter //
create procedure update_salary()
begin 
declare oldsal float(9,0);
declare vset, expr int default 0;
declare vempno int;
declare newsal float(9,0);
declare empsal cursor for select empno,sal, floor(datediff(curdate(),hiredate)/365) 
from emp;
declare continue handler for not found set vset =2;

open empsal;
label: loop
fetch empsal into vempno,oldsal, expr;
if vset =1 then
leave label;
end if;

insert into emp_back (empno, sal) values (vempno,oldsal);

if expr < 2 then
set newsal = oldsal;
elseif expr between 2 and 5 then
set newsal = 1.20 * oldsal;
elseif expr > 25 then
set newsal = 1.25* oldsal;
end if;
update emp set sal = newsal where empno = vempno;
end loop;
close empsal;
end//

delimiter ;



--6
delimiter //
create function exper(feno int) returns int
begin
declare vexp int;
select floor(datediff(curdate(),hiredate)/365) into vexp from emp
where empno = feno;

return vexp;
end//
delimiter ; 


CREATE TABLE emp_allowance
       (EMPNO INT,
        HIREDATE DATE,
        experience int,
        add_allow int);
		
		

delimiter //
create procedure allow_cur()
begin
declare vset int default 0;
declare add_allow,feno int;
declare doj date;
declare empcur cursor for select empno,hiredate from emp;
declare continue handler for NOT FOUND set vset=1;

open empcur;

lable1: loop
fetch empcur into feno,doj;
if vset=1 then
leave lable1;
end if;
insert into emp_allowance (EMPNO,HIREDATE,experience,add_allow) values
(feno,doj,exper(feno),exper(feno)*3000);
end loop;
close empcur;
end//

delimiter ;





--Q2 1

CREATE TABLE EMP_audit
       (EMPNO INT,
        ENAME varchar(10),
        JOB varchar(9),
        MGR INT,
        HIREDATE DATE,
        SAL DECIMAL(7, 2),
        COMM DECIMAL(7, 2),
        DEPTNO INT,
		event varchar(20),
		username varchar(20),
		chng_date date);

delimiter //
create trigger sat_sun
before insert on emp
for each ROW
begin
if dayname(curdate()) = 'saturday' or dayname(curdate()) = 'sunday'
then 
insert into emp_audit values
(new.empno,new.ename, new.job,  new.mgr, new.hiredate,new.sal,new.comm, new.deptno,'insert', user(),curdate());
end if;	
end//

delimiter ;



delimiter //
create trigger sat_sun_delete
before delete on emp
for each ROW
begin
if dayname(curdate()) = 'saturday'
then 
insert into emp_audit values
(old.empno,old.ename, old.job,  old.mgr, old.hiredate,old.sal,old.comm, old.deptno,'delete', user(),curdate());
end if;	
end//
delimiter ;



insert into emp values (120,'ARUNaaa','clerk',7839,'1981-09-10',1600,10,30);



--2
create table orderss(
id int,
qty int,
cost int);

insert into orderss values
(1,4,200),
(2,6,700),
(3,2,300),
(4,3,500);

create table order_history(
id int,
old_qty int,
new_qty int,
old_cost int,
new_cost int,
username varchar(20),
chng_date date);


delimiter //
create trigger update_order
before update on orderss
for each row
begin
insert into order_history values
(new.id,old.qty, new.qty, old.cost, new.cost,user(),curdate());
end//

delimiter ;




_______________________________________________________ASSignment 2________________________________________________________________

--1
delimiter //
create procedure peri_area(l int, w int)
begin
declare area, peri int;

set area = l*w;
set peri = 2*(l+w);
select area,peri;
end//

delimiter ;


--2
create table tempp(
val int,
cubee int,
sqaure int);

delimiter //
create procedure math()
begin
declare num int default 20;
declare cubee, sqr int;

set cubee= num*num*num;
set sqr = num*num;

insert into tempp values (num,cubee,sqr);
end//

delimiter ;


--3
delimiter //
create procedure fc(fr float(9,2),cel float(9,2))
begin

set fr = 9/5*cel + 32;
set cel = (fr-32)*5/9;

select fr,cel;
end//

delimiter ;


--4





--5
delimiter //
create procedure divi(num int, out remark varchar(20))
begin

if num % 5 = 0
then set remark = 'divisible';
else
set remark = 'not divisible';
end if;
select remark;
end//

delimiter ;









































