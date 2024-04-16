db.emp1.insert({empno:111, ename:"Deepali Vaidya",    sal:40000.00, dept:{deptno:11,dname:"Hr",dloc:"Mumbai"}, Desg:"Analyst",    mgr:{name:"Satish",num:107},project:[{name:"Project-1",Hrs:4},{name:"Project- 2",Hrs:5}]})

db.emp1.insert({empno:112, ename:"Arun Gawli", sal:50000.00, dept:{deptno:12,dname:"Photography",dloc:"Mumbai"}, Desg:"Artist", mgr:{name:"Guru",num:100},project:[{name:"Project-2",Hrs:5},{name:"Project-1",Hrs:4}]})


db.emp1.insert({empno:113, ename:"Manohar Surve", sal:60000.00, dept:{deptno:13,dname:"Gangsta",dloc:"Pune"}, Desg:"Shooter", mgr:{name:"Anwar",num:101},project:[{name:"Project-1",Hrs:4},{name:"Project-2",Hrs:5}]})

db.emp1.insert({empno:114, ename:"Sandeep Mohol", sal:80000.00, dept:{deptno:14,dname:"Contractor",dloc:"Pune"}, Desg:"Wasooli", mgr:{name:"Sharad",num:105},project:[{name:"Project-2",Hrs:5},{name:"Project-1",Hrs:4}]})

db.emp1.insert({empno:115, ename:"Sultan Mirza", sal:100000.00, dept:{deptno:15,dname:"Politician",dloc:"Mumbai"}, Desg:"Politics", mgr:{name:"Pinky",num:106},project:[{name:"Project-2",Hrs:5},{name:"Project-1",Hrs:4}]})

--------------------------------------------------------------------------------------------------------------------------------------------------




--q1
db.emp1.updateOne({Desg:'Wasooli'},{$set:{Desg:'AO'}})

--q2 Change the number of hours for project-1 to 5 for all employees with designation analyst.
--db.emp1.updateMany({},{Desg:'Analyst'},{$set:{'project.Hrs':7}})
--db.emp1.updateMany({'project.name':/^Project-1/}
--db.emp1.updateMany({},{Desg:'Analyst'},{$set:{'project.$[elem].Hrs':7}},{arrayFilter:[{'elem.name':{$eq:'Project-1'}}]})       ,{multi:true})

db.emp1.updateMany({ "project": {  $elemMatch: { "name": { $eq:"Project-1" } } },Desg:'Analyst' }, { $inc: {"project.$[].Hrs": 7}})


--q3 
db.emp1.updateMany({ename:/^Deep/},{$push:{project:{$each:[{name:'Project-4',Hrs:2},{name:'Project-5',Hrs:2}]}}})

--q4 Add bonus rs 2000 for all employees with salary > 50000
db.emp1.updateMany({sal:{$gt:50000}},{$inc:{sal:2000}});

--q5 add bonus 1500 if salary <50000 and > 30000
db.emp1.updateMany({sal:{$gt:30000,$lt:50000}},{$inc:{sal:3500}})

--q6 add bonus 1000 if salary <=30000
db.emp1.updateMany({sal:{$lt:50000}},{$inc:{sal:1000}})

--q7 Change manager name to Tushar for all employees whose manager is currently “satish”
--And manager number to 3333
db.emp1.updateMany({'mgr.name':"Satish"},{$set:{'mgr.0.name':"Tushar",'mgr.1.num':3333}})

--q8 Increase salary of all employees from “purchase department” by 15000
db.emp1.updateMany({'dept.dname':"Hr"},{$inc:{sal:15000}})

--q9 Decrease number of hrs by 2 for all employees who are working on project-2
db.emp1.updateMany({ "project": {  $elemMatch: { "name": { $eq:"Project-2" } } } }, { $inc: {"project.$[].Hrs": -2}})
--db.emp1.updateMany({},{$inc:{'project.$[elem].Hrs':-2}},{arrayFilter:[{'elem.name':"Project-2"}]})
--db.companies.updateMany({ "employees": {  $elemMatch: { "salary": { $lte: 8000 } } } }, { $inc: {"employees.$[].salary": 500}})
--db.emp1.updateMany({},{$inc:{'project.$[elem].2':-2}},{arrayFilter:[{'elem.project.name':'Project-2'}]})


--q10. Delete project-2 from all employee document if they are working on the project for 4hrs. 
db.emp1.update({'project.name':'Project-2'},{$pull:{"project":{$elemMatch:{name:"Project-2","Hrs":3}}}},{multi:true});

db.emp1.update({"project":{$elemMatch:{name:'Project-2',Hrs:3}}},{$pull:{"project":{name:"Project-2",Hrs:3}}},{multi:true});
db.emp1.update(

db.emp1.insert({empno:111, ename:"Deepali Vaidya",    sal:40000.00, 
dept:{deptno:11,dname:"Hr",dloc:"Mumbai"}, 
Desg:"Analyst",    mgr:{name:"Satish",num:107},
project:[{name:"Project-1",Hrs:4},{name:"Project- 2",Hrs:5}]})



db.movie.update({name:'kashmir files'},{$set:{price:300},$inc:{rating:3}},{multi:true,upsert:true})

db.emp1.update({},{$pull:{"project":{$elemMatch:{"project.name":"Project-2","project.Hrs":3}}}},{multi:true});
db.emp.update({},{$pull:{'project.name':'project-2','project.Hrs':4}},{multi:true})

db.emp1.update({'project.name':'Project-2'},{$pull:{"project.name":'Project-2', 'project.Hrs':3}},{multi:true});