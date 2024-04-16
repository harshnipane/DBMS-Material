
create DATABASE college;

use college;


create table student(
sid int primary key,
sname varchar(20) not null,
address varchar(120)
);

create table course(
cname varchar(20) primary key,
durtion int,
discription varchar(20)
);

create table stud_marks(
sid int,
cname varchar(20),
marks int check(marks BETWEEN 0 and 100),
primary key(sid,cname),
constraint fk_nm foreign key(sid) REFERENCES student(sid),
constraint fk_cnm foreign key(cname) REFERENCES course(cname)
);


insert into stud_marks VALUES
(1,'java',98),
(2,'sql',89),
(3,'cloud',85),
(4,'linux',70);

insert into course VALUES
('java',3,'programing'),
('sql',4,'query'),
('linux',2,'cmd'),
('cloud',4,'computing');

insert into student VALUES
(1,'harsh','bhnadara'),
(2,'suyog','bhandara'),
(3,'aditya','pune'),
(4,'ram','nagpur');

create table owner (
ownerid int primary key,
oname varchar(20),
address varchar(30));

create table vehicle(
vid int primary key,
vname varchar(20),
model varchar(20),
company varchar(20),
ownerid int,
sid int,
constraint fk_onm foreign key(ownerid) REFERENCES owner(ownerid),
constraint fk_si foreign key (sid) REFERENCES salesman(sid));

create table salesman(
sid int primary key,
sname varchar(20),
address varchar(30));

ALTER TABLE vehicle
DROP FOREIGN KEY `fk_onm`;

alter table vehicle
ADD CONSTRAINT `fk_onm2`
  FOREIGN KEY (`ownerid`)
  REFERENCES owner(`ownerid`)
  ON DELETE set null
  ON UPDATE CASCADE;
  
  
 create database ipl;
use ipl; 
  
  create table player(
    playerid int primary key,
    pname varchar(20),
    speciality varchar(20),
    date_of_joining date,
    num_matches int,
    team_id int,
    constraint fk_tid foreign key(team_id) references team(team_id) 
	on update cascade on delete set null);

create table team(
team_id int primary key,
tname varchar(20),
player_num int );

create table matches(
match_id int primary key,
team1 int,
team2 int,
match_date date,
winner varchar(20),
man_of_the_match int,
constraint fk_mom foreign key(man_of_the_match) references player(playerid) on delete set null on update cascade,
constraint fk_t1 foreign key(team1) references team(team_id) on delete set null on update cascade,
constraint fk_t2 foreign key(team2) references team(team_id) on delete set null on update cascade);




-- Inserting data into the "player" table for cricket
INSERT INTO player (playerid, pname, speciality, date_of_joining, num_matches, team_id) 
VALUES
(1, 'Virat Kohli', 'Batsman', '2008-08-18', 250, 1),
(2, 'Rohit Sharma', 'Batsman', '2007-06-23', 220, 1),
(3, 'Jasprit Bumrah', 'Bowler', '2016-01-23', 150, 1),
(4, 'MS Dhoni', 'Wicketkeeper-Batsman', '2004-12-23', 350, 2),
(5, 'Ravindra Jadeja', 'All-rounder', '2009-02-10', 280, 2),
(6, 'Steve Smith', 'Batsman', '2010-05-02', 200, 3),
(7, 'David Warner', 'Batsman', '2009-09-18', 220, 3),
(8, 'Kane Williamson', 'Batsman', '2010-08-03', 210, 3),
(9, 'Trent Boult', 'Bowler', '2011-11-15', 180, 4),
(10, 'Shakib Al Hasan', 'All-rounder', '2006-04-04', 260, 5),
(11, 'Joe Root', 'Batsman', '2012-07-10', 190, 4),
(12, 'Babar Azam', 'Batsman', '2015-06-05', 160, 5),
(13, 'Mitchell Starc', 'Bowler', '2011-02-18', 170, 6),
(14, 'AB de Villiers', 'Batsman', '2004-10-23', 280, 6),
(15, 'Kagiso Rabada', 'Bowler', '2015-09-30', 150, 7);

-- Inserting data into the "team" table for cricket
INSERT INTO team (team_id, tname, player_num)
VALUES
(1, 'India', 15),
(2, 'West Indies', 15),
(3, 'Australia', 15),
(4, 'New Zealand', 15),
(5, 'Bangladesh', 15),
(6, 'South Africa', 15),
(7, 'England', 15);

-- Inserting data into the "matches" table for cricket
INSERT INTO matches (match_id, team1, team2, match_date, winner, man_of_the_match)
VALUES
(1, 1, 3, '2021-10-05', 1, 1),
(2, 2, 1, '2021-11-20', 1, 2),
(3, 3, 1, '2022-01-03', 3, 7),
(4, 4, 2, '2021-09-15', 4, 8),
(5, 5, 1, '2022-02-28', 5, 10),
(6, 3, 2, '2022-03-10', 3, 6),
(7, 4, 1, '2022-04-15', 1, 1),
(8, 5, 3, '2022-05-20', 3, 10),
(9, 6, 1, '2022-06-25', 1, 14),
(10, 2, 3, '2022-07-30', 3, 7),
(11, 4, 5, '2022-08-05', 5, 10);


 
 update team
    set player_num = 15
    where team_id in (2,3,4,5,6,7);
 




select pname from player
where team_id in  (select team1 from matches where YEAR(match_date) = 2021) or  team_id in  (select team2 from matches where YEAR(match_date) = 2021);


select match_id from matches
where team1 = (select team_id from player
				where matches.man_of_the_match = player.playerid
	
	
select all from matches 
where exist (select all from matches where mam_of_the_match = playerid)	



select match_id from matches
where winner in (select team_id from team
where tname in ('India','Australia'));			


select team_id, tname from team 
where team_id in  (select winner from matches );



select * from team t 
where not exist (select * from matches m where m.team1 = t.team_id or m.team2 = m.team_id);


select team_id from team  
where team_id not in(select team1 from matches ) or team_id not in(select team1 from matches )



select team_id from team 
where team_id not in (select distinct team_id from players



select tname from team
where team_id =any(select winner from matches
group by winner 
having count(winner) > 3);





create database movie;
use movie;

create table Movies (
id int primary key,
Title varchar(20),
director varchar(20),
Year year check(year>1990),
Length_min int check(length_min between 15 and 240),
Release_date date);



create table Boxoffice(
movieid int primary key,
rating FLOAT check(rating < 10),
Domestic_sales int,
Internantional_sales int,
CONSTRAINT fk_mid foreign key(movieid) REFERENCES Movies(id));



insert into Movies values
(1, 'Inception', 'Christopher Nolan', 2010, 108, '2010-07-16'),
(2, 'Shawshank Redemption', 'Frank Darabont', 1994, 112, '1994-10-14'),
(3, 'Pulp Fiction', 'Quentin Tarantino', 1994, 124, '1994-10-14'),
(4, 'The Dark Knight', 'Christopher Nolan', 2008, 92, '2008-07-18'),
(5, 'Forrest Gump', 'Robert Zemeckis', 1994, 98, '1994-07-06'),
(6,'Toy story','John Lasseter',1995,81,'1995-03-02'),
(7,'A Bugs Life','John Lasseter',1998,95,'1998-03-02');


-- Inserting entries into the Boxoffice table
INSERT INTO Boxoffice values
(1, 8.8, 292576195, 535700000),
(2, 9.3, 28699976, 28341469),
(3, 8.9, 107928762, 213928762),
(4, 9.0, 535234033, 469700000),
(5, 7.8, 330252182, 347693217);



create database vehicles;
use vehicles;


create table Vehicle(
vid int primary key,
vname varchar(20),
price int,
description varchar(50));

create table customer(
cid int primary KEY,
cname varchar(20),
address varchar(20));

create table SALESMAN(
Sid int primary key,
Sname varchar(20),
address varchar(20));

create table custvehical(
cid int,
vid int,
Sid int,
Buyprice int,
primary key(cid,vid),
CONSTRAINT frsid foreign key(Sid) REFERENCES SALESMAN(Sid),
CONSTRAINT frvid foreign key(vid) REFERENCES vehicle(vid),
CONSTRAINT frcid foreign key(cid) REFERENCES customer(cid)
);


insert into Vehicle VALUES
(1, 'Activa', 80000, 'indias fav'),
(2, 'Santro', 800000, 'middle class'),
(3, 'Motor bike', 100000, 'for bikers');

insert into customer VALUES
(1, 'Nilima', 'Pimpari'),
(2, 'Ganesh', 'Pune'),
(3, 'Pankaj', 'Mumbai');

insert into SALESMAN VALUES
(10, 'Rajesh', 'Mumbai'),
(11, 'Seema', 'Pune'),
(13, 'Rakhi', 'pune');

insert into custvehical VALUES
(1,1,10,75000),
(1,2,10,790000),
(2,3,11,80000),
(3,3,11,75000),
(3,2,10,800000);


select cname, vname, sname, round((v.price - cv.Buyprice)*100/v.price,2) as discount
from Vehicle v join custvehical cv on v.vid = cv.vid
join SALESMAN s on cv.sid = s.sid 
join customer c on cv.cid = c.cid ;



select cname, vname, sname
from Vehicle v join custvehical cv on v.vid = cv.vid
join SALESMAN s on cv.sid = s.sid 
join customer c on cv.cid = c.cid 
where s.address = 'pune';

insert into mgr30
values(7700,"Harsh",'manager',7839, '1981-09-08', 2000, 100, 30),
(7710,"suyog",'salesman',7700, '1981-09-08', 1000, 0, 30),
(7720,"aditya",'salesman',7700, '1981-09-08', 1500, 10, 30);



create table ABC(
aid int,
bid varchar(20),
cid int);


insert into abc values
(1,'harsh',10),
(2,'suyog',20),
(3,'aditya',30);


select * from(
select empno, ename, deptno,sal,
dense_rank() over(partition by deptno order by sal) as drankhr
from emp) x
where x.drank = 1;




insert into emp values
(103,"sumit",'manager',7839, '1981-09-010', 1600, 10, 30),
(104,"Suraj",'salesman',7700, '1981-09-21', 1000, 0, 30),
(105,"jadhav",'salesman',7700, '1981-09-6', 1500, 100, 30);




delimiter //
create procedure getmin()
BEGIN
select deptno, min(sal) as minsal
from emp
group by deptno;
end//
delimiter;









____________________________________STOREDPROCEDURE___________________________________


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


______________________________CURSORRRRRRRRRRRR_____________________________________________
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




________________________________FUNCTIONS_______________________________________

generate email 

delimiter //

create function generatemail(fename varchar(20),fjob varchar(20)) returns varchar(30)
BEGIN
	declare vemail varchar(30);
	set vemail = concat(substr(fename,3,4),'.',left(fjob,3),'@mycompany.com');
	return vemail;
end//

delimiter ;	



________________________________________TRIGGERS__________________________________


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
	(new.deptno, new.dname, null, new.loc,  null,  user(),curdate(),'delete');	
end//
delimiter ;
	