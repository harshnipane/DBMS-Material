
CREATE KEYSPACE iacsd0324 WITH replication={'class':'SimpleStratagy','replication_factor':'1'};

create table customer(cno int primary key,cname text,mobile text);

insert into customer (cno,cname,mobile) values (2,'nitin','79374658');

_____________________________________________________________________________________________


create table employee(
             empid int,
             emp_firstname text,
             emp_lastname text,
             emp_sal decimal,
             emp_dob date,
             emp_deptno int,
             emp_comm float,
             primary key((empid, emp_sal), emp_firstname,emp_dob));
			 
			 
 insert into employee (empid,emp_firstname,emp_lastname,emp_sal,emp_dob, emp_deptno, emp_comm) values (1001,'aditya','khomane',2100,'1990-05-30',20,100);	


_______________________________________________________________________________________________


 alter table customer add email varchar;



update customer
set email = 'suyog@gmail.com'
where cno =1; 


alter tble customer drop 
email;

alter tbale customer add bill_amount float;


updat customerset 
set bill_amount = 5000
where cno =1;

updat customerset 
set bill_amount = 4000
where cno =2;

_____________________________________________________________________________________________

select cno =2, sum(bill_amount), max(bill_amount), min(bill_amount)
from customer;



_____________________________________________________________________________________________
DATA TYPES COLLECTION
set tuple list map




SET - 

alter table customer add brands set<text>;


update customer set brands = {'puma','nike'} where cno =1;



update customer set brands= brands+{'puma','nike'} where cno =1;

 cno | brands                     | cname  | email | mobile
-----+----------------------------+--------+-------+----------
   1 | {'a', 'b', 'nike', 'puma'} | rajesh |  null | 89374598
   2 |                       null |  nitin |  null | 79374658
   
   
   
update customer set brands= brands-{'b'} where cno =1;
   
  cno | brands                | cname  | email | mobile
-----+-----------------------+--------+-------+----------
   1 | {'a', 'nike', 'puma'} | rajesh |  null | 89374598
   2 |                  null |  nitin |  null | 79374658  
   
   
   
UPDATE customer
SET BRANDS = {}
WHERE CNO=1;





LIST 


create table student(
sid int primary key,
sname text,
hobbies list<text>,
courses set<text>);


insert into student (sid,sname,hobbies,courses) values (1,'ram',['dancing','coocking'],{'java','python'});

 sid | courses            | hobbies                 | sname
-----+--------------------+-------------------------+-------
   1 | {'java', 'python'} | ['dancing', 'coocking'] |   ram



update student 
set hobbies[1] = 'trekking'
where sid =1;

sid | courses            | hobbies                 | sname
-----+--------------------+-------------------------+-------
   1 | {'java', 'python'} | ['dancing', 'trekking'] |   ram
   
   
update student 
set hobbies =hobbies+ ['trekking']
where sid =1;   


update student 
set hobbies =hobbies- ['trekking']
where sid =1; 






map



 alter table student add marks map<text,int>;
 
 update student set marks = {'java':78,'python':86} where sid =1;
 select * from student;

 sid | courses            | hobbies                 | marks                      | sname
-----+--------------------+-------------------------+----------------------------+-------
   1 | {'java', 'python'} | ['dancing', 'trekking'] | {'java': 78, 'python': 86} |   ram
   
   
update student set marks = marks + {'cpp':84} where sid =1;    

 sid | courses            | hobbies                 | marks                                 | sname
-----+--------------------+-------------------------+---------------------------------------+-------
   1 | {'java', 'python'} | ['dancing', 'trekking'] | {'cpp': 84, 'java': 78, 'python': 86} |   ram
   

update student set marks = marks - {'cpp'} where sid =1;

 sid | courses            | hobbies                 | marks                      | sname
-----+--------------------+-------------------------+----------------------------+-------
   1 | {'java', 'python'} | ['dancing', 'trekking'] | {'java': 78, 'python': 86} |   ram
   
   
   
   
TUPLE


alter table student add degree tuple<text,text,int>;

update student set degree = ('mtech','pu',89)
where sid = 1;

 sid | courses            | degree              | hobbies                 | marks                      | sname
-----+--------------------+---------------------+-------------------------+----------------------------+-------
   1 | {'java', 'python'} | ('mtech', 'pu', 89) | ['dancing', 'trekking'] | {'java': 78, 'python': 86} |   ram
   
   
   
   
create table test(
id int ,
name varchar(20),
data list<tuple<int,text>>,
data2 map<text,list<text>>);   




Assignment

CREATE TYPE COLLECTION (movie text, director text, song text);

create table singer(
sid int,
name text,
song list<text>,
dirctors map<text,int>,
studio map<text,int>,
movie_director_song list<FROZEN <COLLECTION>>,
primary key(sid,name));


insert into singer (sid,name,song,dirctors,studio, movie_director_song) values 
(1,'sonu nigam',['song1','song2'],{'ram':2,'sham':3},{'coke':3,'zoom':1},[('movie1','ram','songx'),('movie2','RAHUL','songY')])

insert into singer (sid,name,song,dirctors,studio, movie_director_song) values 
(2,'shan',['fanna','shansng'],{'rohit':2,'aditya':3},{'coke':4,'zoom':3},[('movie_a','rahul','songd'),('movie_b','aditi','songp')])

insert into singer (sid,name,song,dirctors,studio, movie_director_song) values
(3,'shreya',['main agar','sjjsnd'],{'shreyash':4,'dev':1},{'coke':1,'zoom':5},[('movie_js','rohit','songww'),('movie_p1','abhay','song7')])




begin batch 

insert into singer (sid,name,song,dirctors,studio, movie_director_song) values 
(4,'xxxx',['songx','songxx'],{'ram':2,'sham':3},{'coke':3,'zoom':1},[('moviexx','ram','songxxx'),('moviex','RAHUL','songxhf')]);

insert into singer (sid,name,song,dirctors,studio, movie_director_song) values 
(5,'yyyy',['fannayy','shanyyyy'],{'rohit':2,'aditya':3},{'coke':4,'zoom':3},[('movie_yy','rahul','songy'),('movie_y','aditiyy','songyutuyy')]);

delete from singer where sid =4 and name ='xxxx';

apply batch



create type ser(storeid int, name text, ram int);

create table location(
bldgname text,
floorno int,
server list<FROZEN <ser>>,
primary key((bldgname),floorno));


insert into location(bldgnamefloorno,server) values
('A',10,[(2,'aaaa',2000),(3,'aaaa2',3000)]);

insert into location(bldgnamefloorno,server) values
('B',5,[(6,'bbbb',1500),(4,'bbbb2',2500)]);

insert into location(bldgnamefloorno,server) values
('C',7,[(5,'cccc',3000),(2,'cccc2',1000)]);
























   
   




 






   
   
   
 





   
   
   
   
   
   
   
   
   
   
   
   
   







