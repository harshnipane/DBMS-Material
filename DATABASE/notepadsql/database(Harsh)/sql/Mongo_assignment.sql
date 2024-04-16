db.emp1.insert({empno:111, ename:"Deepali Vaidya",    sal:40000.00, dept:{deptno:11,dname:"Hr",dloc:"Mumbai"}, Desg:"Analyst",    mgr:{name:"Satish",num:107},project:[{name:"Project-1",Hrs:4},{name:"Project- 2",Hrs:5}]})

db.emp1.insert({empno:112, ename:"Arun Gawli", sal:50000.00, dept:{deptno:12,dname:"Photography",dloc:"Mumbai"}, Desg:"Artist", mgr:{name:"Guru",num:100},project:[{name:"Project-2",Hrs:5},{name:"Project-1",Hrs:4}]})


db.emp1.insert({empno:113, ename:"Manohar Surve", sal:60000.00, dept:{deptno:13,dname:"Gangsta",dloc:"Pune"}, Desg:"Shooter", mgr:{name:"Anwar",num:101},project:[{name:"Project-1",Hrs:4},{name:"Project-2",Hrs:5}]})

db.emp1.insert({empno:114, ename:"Sandeep Mohol", sal:80000.00, dept:{deptno:14,dname:"Contractor",dloc:"Pune"}, Desg:"Wasooli", mgr:{name:"Sharad",num:105},project:[{name:"Project-2",Hrs:5},{name:"Project-1",Hrs:4}]})

db.emp1.insert({empno:115, ename:"Sultan Mirza", sal:100000.00, dept:{deptno:15,dname:"Politician",dloc:"Mumbai"}, Desg:"Politics", mgr:{name:"Pinky",num:106},project:[{name:"Project-2",Hrs:5},{name:"Project-1",Hrs:4}]})






{
    _id: ObjectId('660fd42007c6eb9c069f990f'),
    empno: 117,
    ename: 'Suraj singh',
    sal: 100000,
    dept: { deptno: 15, dname: 'Politician', dloc: 'Mumbai' },
    Desg: 'Politics',
    mgr: { name: 'Pinky', num: 106 },
    project: [ { name: 'Project-3', Hrs: 5 }, { name: 'Project-4', Hrs: 4 } ]
 }
 
 

db.employee.updateMany({Desg:'scientist'},{$set:{Desg:'Clerk'}})


--1
db.employee.updateMany({Desg:'Clerk'},{$set:{Desg:'AO'}})



db.employee.updateMany({"project":{$elemMatch:{"name":"Project-1"}},Desg:"Analyst"},{$set:{project:{name:"Project_1"Hrs:5}}})
db.employee.updateMany({project:{$elemMatch:{name: "Project-1"}},Desg:"Analyst"},{$unset:{project:''}})

db.employee.update({Desg:"Analyst"},{$push:{project:{$each:[{name:"project-3",Hrs:2},{name:'project-4',Hrs:2}]}}},{multi:true})



--3
db.employee.update({ename:/^dipak/},{$push:{project:{$each:[{name:'project-3',Hrs:2},{name:"project-4,Hrs:2"}]}}},{multi:true})


--4
db.employee.update({sal:{$gt:40000}},{$inc:{sal:2000}},{multi:true});


--5
db.employee.update({sal:{$lt:50000,$lt:30000}},{$inc:{sal:1500}},{multi:true});


--6
db.employee.update({sal:{$gte:30000}},{$inc:{sal:1000}},{multi:true});


--7
db.employee.update({'mgr.name':'satish'},{$set:{'mgr.0.name':"Tushar",'mgr.1.num':333}},{multi:true})


--8
db.employee.update({'dept.dname':'Hr'},{$inc:{sal:15000}},{multi:true})


--9
db.employee.updateMany({"project":{$elemMatch:{name:'Project-2'}}},{$inc:{"project.$[].Hrs":-2}});


-10
db.employee.update({},{$pull:{project:{name:'Project-2',Hrs:4}}},{multi:true});

db.emp.update({},{$pop:{"project":{$elemMatch:{name:"Project-2","Hrs":1}}}},{multi:true});


--11
db.employee.update({sal:{$lt:10000}},{$max:{sal:10000}});


--12
db.employee.update({$or:[{sal:{$lt:20000}},{'dept.dname':'Sales'}]},{$inc:{sal:500}});


--13
db.employee.update({$or:[{Desg:'Analyst'},{sal:{$in:['30000','100000','35000']}}]},{$push:{project:{$each:[{name:'Projetct-4',Hrs:2},{name:'Projetct-5',Hrs:4}],$position:1}}},{multi:true});


--14
db.employee.update({'dept.dname':'Photography','dept.dloc':'Mumbai'},{$pop:{project:1}});


--15
db.employee.update({"project":{$elemMatch:{name:'Project-1',Hrs:4}}},{$set:{Desg:'senior programmer'}},{multi:true});



--16
db.employee.update({'mgr.name':'Pinky'},{$set:{hobbies:['cooking','gaming']}});


--17
db.employee.update({"project":{$elemMatch:{$or:[{name:'Project-1',Hrs:4},{name:'Project-2',Hrs:5}]}}},{$set:{skillset:['python','Java']}},{multi:true});


--18
db.employee.update({ename:/^[AM].*[ie]$/},{$push:{hobbies:{$each:['blogging'],$position:2}}},{multi:true});


--19
bd.employee.update({"project":{$elemMatch:{name:{$in:['Project-3','Project-1']}}}},{$inc:{sal:1}},{multi:true});


db.employee.updateMany({},{$set:{bonus:2000}});


--20
db.employee.update({'dept.dloc':'Mumbai'},{$inc:{bonus:-1000,sal:1000}},{multi:true});





--23
db.employee.updateMany({"skillset": "python" },{$set:{"skillset.$[element]": "python 3.8" }},{arrayFilters: [{ "element": "python" }] });


--24
db.employee.update({'dept.dloc':'pune'},{$push:{skillset:{$each:['MongoDb', 'Perl'],$position:}}},{multi:true});


--25
bd.employee.update({"project":{$elemMatch:{name:{$in:['Project-3','Project-1']}}}},{$pop:{hobbies:-1}},{multi:true});





--27
db.employee.update({skillset:{$in:['Perl','Python 3.8']}},{$push:{project:{$each:[{name:'Project-6',Hrs:2},{name:'Project-7',Hrs:3}]}}},{multi:true});


--28
db.employee.update({"project":{$elemMatch:{name:'Project-1'}}},{$max:{project:{}}})