   ________________________________________________________MONGODB___________________________________________
   
db.movie.find({name:'kahani'}) 


--all movies (name,rating,price)
db.movie.find({},{name:1,price:1,rating:1}) 


--all movies with price>200 and <600
db.movies.find({price:{$gt:200,$lt:600}}) 


--to find all movies with price = either 200 or 310 or 500
db.movies.find({price:{$in:[200,310,500]}})

$nin


--to find all movies with price > 200 and ticketnum > 150
db.movie.find({price:{$gt:200},ticket_num:{$gt:150}})


db.movie.find({rating:{$in:[null]}}) --it will show all the movies with rating = null and 
also show the movies  do not having rating key


db.movie.find({rating:{$in:[null],$exist:true}})


--show the movies  do not having rating key
db.movie.find({rating:{$in:[null],$exist:false}})


--movie with actor amitabh
db.movie.find({actor:'Amitabh'})


--movie with actor amitabh and position = 0th
db.movie.find({'actor.0':'Amitabh'})


--movie with actor having size 3
db.movie.find({actor:{$size:3}})


--movies with rating divisible by 7
db.movie.find({rating:{$mod:[7,0]}})
\

--movies with even rating
db.movie.find({rating:{$mod:[2,0]}})


--movies with rating value is in string format
db.movie.find({rating:{$type,''string}})


--movies released in year 2016
db.movie.find({"$expr" : {"$eq": [{"$year": "$rdate"},2019]}})


--find all restaurant with longitude > 40
db.restaurant.find({'address.coord.1':{$gt:40}})


db.restaurant.find().count();
--



db.restaurant.find().skip(20000).limit(2).sort({name:-1});



--find first 3 movie with rating >4
db.movie.find({rating:{$gt:4}}).limit(3);



--find first 4th nd 5th movie with rating >4
db.movie.find({rating:{$gt:4}}).limit(3).skip(2);



-- sort rating in DESC
db.movie.find({rating:{$gt:4}}).limit(3).skip(2).sort({rating:-1})


-- restaurant with score 38
db.restaurant.find({'grades.score':38});


--from different row
db.restaurant.find({'grades.score':38,'grades.grade':'A'});


--from same row
db.restaurant.find({grades:{$elematch:{grade:'c',score:38}}});



--actor 'Amitabh', 'amitabh'
db.movie.find({actor:/^[Aa]mitabh/});

--using regexp
db.movie.find({actor:{$regex:'[Aa]mitabh'}});


--all movies ending with t
db.movie.find({name:/t$/});


-- all movies starts with digit
bd.movie.find((name:/^[0-9]/))

\d ----- matches with any digit CHARACTER
\D ----- matches with any nondigit CHARACTER
\w ----- matches with one word character[0-9,a-z,A-Z]
\W ----- matches with one non word character [^0-9a-zA-Z]
\s ----- matches with one SPACE
\S ----- matches with one non space character




db.movie.find({name:/^p.*t$|i$/});







_________________________Assignment__________________________________________

{
    _id: ObjectId('660d1c6048a0bee927ce49a6'),
    address: {
      building: '129-08',
      coord: [ -73.839297, 40.78147 ],
      street: '20 Avenue',
      zipcode: '11356'
    },
    borough: 'Queens',
    cuisine: 'Delicatessen',
    grades: [
      {
        date: ISODate('2014-08-16T00:00:00.000Z'),
        grade: 'A',
        score: 12
      },
      {
        date: ISODate('2013-08-27T00:00:00.000Z'),
        grade: 'A',
        score: 9
      },
      {
        date: ISODate('2012-09-20T00:00:00.000Z'),
        grade: 'A',
        score: 7
      },
      {
        date: ISODate('2011-09-29T00:00:00.000Z'),
        grade: 'A',
        score: 10
      }
    ],
    name: "Sal'S Deli",
    restaurant_id: '40361618'
  }

--1. Write a MongoDB query to display all the documents in the collection restaurants
db.restaurant.find();

--2 Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine for
--all the documents in the collection restaurant.

db.restaurant.find({},{restaurant_id:1,name:1,borough:1,cuisine:1});



--3.Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine,
--but exclude the field _id for all the documents in the collection restaurant.

db.restaurant.find({},{restaurant_id:1,name:1,borough:1,cuisine:1,_id:0});



--4 Write a MongoDB query to display the fields restaurant_id, name, borough and zip code,
--but exclude the field _id for all the documents in the collection restaurant.

db.restaurant.find({},{restaurant_id:1,name:1,borough:1,'address.zipcode':1,_id:0});



--5 Write a MongoDB query to display all the restaurant which is in the borough Bronx

db.restaurant.find({borough:'Bronx'});



--6 Write a MongoDB query to display the first 5 restaurant which is in the borough Bronx.

db.restaurant.find({borough:'Bronx'}).limit(5);



--7.Write a MongoDB query to display the next 5 restaurants after skipping first 5 which are in
--the borough Bronx.

db.restaurant.find({borough:'Bronx'}).limit(5).skip(5);



--8 Write a MongoDB query to find the restaurants who achieved a score more than 90.

db.restaurant.find({'grades.score':{$gt:90}});



--9 Write a MongoDB query to find the restaurants that achieved a score, more than 80 but
--less than 100.

db.restaurant.find({'grades.score':{$gt:80,$lt:100}});



--10 Write a MongoDB query to find the restaurants which locate in latitude value less than -
95.754168.

db.restaurant.find({'address.coord.0':{$lt:95.754168}});



--11 Write a MongoDB query to find the restaurants that do not prepare any cuisine of
--'American' and their grade score more than 70 and latitude less than -65.754168.

db.restaurant.find({cuisine:{$ne:'American'},'address.coord.0':{$lt:95.754168},'grades.score':{$lt:80}});



--12 Write a MongoDB query to find the restaurants which do not prepare any cuisine of
--'American' and achieved a score more than 70 and located in the longitude less than 65.754168.

db.restaurant.find({cuisine:{$ne:'American'},'address.coord.1':{$lt:-65.754168},'grades.score':{$gt:70}});



--13 Write a MongoDB query to find the restaurants which do not prepare any cuisine of
--'American ' and achieved a grade point 'A' not belongs to the borough Brooklyn. The
--document must be displayed according to the cuisine in descending order.

db.restaurant.find({cuisine:{$ne:'American'},borough:{$ne:'Brooklyn'},'grades.grade':'A'}).sort({cuisine:-1});




--14. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those
--restaurants which contain 'Wil' as first three letters for its name.

db.restaurant.find({name:/^Wil/},{restaurant_id:1,name:1,borough:1,cuisine:1});



--15.Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those
--restaurants which contain 'ces' as last three letters for its name.

db.restaurant.find({name:/ces$/},{restaurant_id:1,name:1,borough:1,cuisine:1});



--16 Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those
--restaurants which contain 'Reg' as three letters somewhere in its name.

db.restaurant.find({name:/.*Reg.*/},{restaurant_id:1,name:1,borough:1,cuisine:1});



--17 Write a MongoDB query to find the restaurants which belong to the borough Bronx and
--prepared either American or Chinese dish.

db.restaurant.find({borough:'Bronx',cuisine:{$in:['American','Chinese']}});



--18. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those
--restaurants which belong to the borough Staten Island or Queens or Bronxor Brooklyn.

db.restaurant.find({borough:{$in:['Staten Island','Queens','Bronxor Brooklyn']} },{restaurant_id:1,name:1,borough:1,cuisine:1});



--19. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those
--restaurants which are not belonging to the borough Staten Island or Queens or Bronxor
--Brooklyn.

db.restaurant.find({borough:{$nin:['Staten Island','Queens','Bronxor','Brooklyn']} },{restaurant_id:1,name:1,borough:1,cuisine:1});



--20. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those
--restaurants which achieved a score which is not more than 10.

db.restaurant.find({'grades.score':{$lte:10}},{restaurant_id:1,name:1,borough:1,cuisine:1});



--21. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those
--restaurants which prepared dish except 'American' and 'Chinees' or restaurant's name begins
--with letter 'Wil'.

db.restaurant.find({$or:[{cuisine:{$nin:['American','Chinese']}}, {name:/^Wil/}]},{restaurant_id:1,name:1,borough:1,cuisine:1});



--22 Write a MongoDB query to find the restaurant Id, name, and grades for those restaurants
--which achieved a grade of "A" and scored 11 on an ISODate "2014-08-11T00:00:00Z"
--among many of survey dates

db.restaurant.find({'grades.grade':'A','grades.score':11,'grades.date':ISODate('2014-08-11T00:00:00Z')},{restaurant_id:1,name:1,grades:1});



--23. Write a MongoDB query to find the restaurant Id, name and grades for those restaurants
--where the 2nd element of grades array contains a grade of "A" and score 9 on an ISODate
--"2014-08-11T00:00:00Z".

db.restaurant.find({'grades.1.grade':'A','grades.1.score':9,'grades.1.date':ISODate('2014-08-11T00:00:00Z')},{restaurant_id:1,name:1,grades:1});



--24. Write a MongoDB query to find the restaurant Id, name, address and geographical
--location for those restaurants where 2nd element of coord array contains a value which is
--more than 42 and upto 52

db.restaurant.find({'address.coord.1':{$gt:42,$lte:52}},{restaurant_id:1,name:1,'address.coord':1});



--25. Write a MongoDB query to arrange the name of the restaurants in ascending order along
--with all the columns.

db.restaurant.find().sort({name:-1});



--26. Write a MongoDB query to arrange the name of the restaurants in descending along with
--all the columns.

db.restaurant.find()sort({rating:1});



--27 Write a MongoDB query to arranged the name of the cuisine in ascending order and for
--that same cuisine borough should be in descending order.

db.restaurant.find().sort({cuisine:-1,borough:1});




































______________________________________________________UPDATE_______________________________________________________



------to update data in mongodb

update: this function is used to  update one or more documents
updateOne : this is used to update only one matching document
updateMany:this is used to update all matching documnet


updateMany({query},{update action})
updateOne({query},{update action})


update({query},
      {update action},
	  {multi:true,upsert:true,arrayFilters:[]})
	  
	  

what update operation
1. add new key-value pair--- $set, $min, $max
2. delete existing key------ $unset
3. overwrite the value of the key --- $set,$min, $max
4. increase or decrease the value of key --- $inc, $mul 
5. to assign current date ---$currentDate
6. to rename the existing key ---$rename

If there is a array of values
1. add a new value array  $push---> $each, $position
2. delete a value from array  $pop,$pull
3. overwrrite 



-----to increase the  price  by 200
-----in $inc if the value is +ve then it will add, but
-----if it is -ve then it will subtrcat
db.movie.updateMany({price:{$nin:[null],$exists:true}},{$inc:{price:-200}});


 
----and overwrite ticke_no value by 100
db.movie.updateMany({name:'padmavat'},{$set:{ticket_num:100}})



----to increase the  price  by 200 
----and overwrite ticke_no value by 100
db.movie.updateMany({name:/^p/},{$inc:{price:200},
         $set:{ticket_no:100},
		 $currentDate:{'lastmodified':true}});
		 
		 
		 
-----to remove ticket_num key from all 
------movies with name starts with p
db.movie.updateMany({name:/^p/},{$unset:{ticket_num:''}})



----to increase the  price  by 10%
-----in $inc if the value is +ve then it will add, but
-----if it is -ve then it will subtrcat
db.movie.updateMany({name:/^p/}},
{$mul:{price:1.10}});




600
-----to update price to 450, if the current price is < 450
---if any price < 450, then overwrite, otherwise kep it as it is
db.movie.update({},{$max:{price:450}},{multi:true})




4
-----to update rating to 3, if the current rating >3
$min means, if any rating is >3, then replace it with 3
db.movie.update({name:/^p/},{$min:{rating:3}},{multi:true})




-----to change the lastmodified ky to lastchange
$rename operator will change key lastmodified to lastchange
db.movie.updateMany({name:/^p/},
{$rename:{'lastmodified':'lastchange'}})



------upsert the following record
upsert means update is exists, otherwise insert




db.movie.update({name:'kashmir files'},
{$set:{price:300},$inc:{rating:3}},
{multi:true,upsert:true})



----- add new actor in 'kashmir files'
db.movie.find({name:'kashmir files'},{$push:{actor:'anupam kher'}})




------add anupam kher at the end in actor array 
-----of kashmir files
db.movie.update({name:'kashmir files'},
 {$push:{actor:'anupam kher'})
 
 
 
 
 
 ------add pallavi joshi and chinamay 
---- at the end in actor array of kashmir files
db.movie.update({name:'kashmir files'},
 {$push:{actor:{$each:['pallavi joshi','chinamay']}})
 
 
 
 
 
 ------add xxxx and zzzzzz at the oth index position in actor array 
 ----of kashmir files
db.movie.update({name:'kashmir files'},
 {$push:{actor:{$each:['xxxx','zzzzzz'],$position:0}})
 
 
 
 


 ------add ppppp at the 3rd index position in actor array 
 ----of kashmir files0
db.movie.update({name:'kashmir files'},
 {$push:{actor:{$each:['ppppp'],$position:3}})
 
 
 
 
----add 'yyyy' at 2 nd index position in actor array 
of file kashmir files
 db.movie.update({name:'kashmir files'},
 {$push:{actor:{$each:['yyyy'],$position:2}}})
 
 
 
 
-----to delete value from actor array from the end
{$pop:{actor:1}  ---$pop will delete last value from actor array
db.movie.update({name:'kashmir files'},
 {$pop:{actor:1}})
 
 
 
 
 
 
 
 
 
 
 
 
 
 db.movie.aggregate([{$project:{name:1,actor:1,rating:1, price:1,ticket_no:1,sumtp:{$add:{($ifnull:['$ticket_no',0],'$price']}}}]);
 
 
 
 
 --find discount price for all movies with rating 1,
 --if the discount is 10 %
 
 db.movie.aggregate([
 {$match:{rating:{$gte:3}}},
 {project:{name1,price:1,rating:1,
 discount1:{$multiply:['$price',0.90]},
 discount2:{$subtract:{$price,{$multiply:['$price',0.10]}]}}}
 
 
 --display all rating in which more than three rating are there
 db.movie.aggregate([
 {$group: {_id:'$rating',
 sump: {$sum: '$price'},
 minp:{$min: '$price'}, maxp: { $max:'$price'},
 count: {$sum: 1} } },
 {$sort:{_id:-1}},{$match:{count:{$gte:3}}}]);
 
 
 
 
 -- sum of all prices ratingwise but display only if sum >600
 db.movie.aggregate([
 {$group:{_id:'$rating',sump:{$sum:'$price',}}},
 {$match:{sump:{$gt:600}}}
 ])
 
 
 
 
 
 -- display name adress email, for all student as name followed by . followed by first 3 letters of name, followed by @mycompany.COM 
 --ex ashish.ash@mycompany.com
db.student.aggregate([
{$project:{name:1,address:1,
email:{$concat:['$name','.',{$substr:['$name',0,3]},'@mycompany.com']}}}
])

--find 3 movies which ticket price are hisghest, arrange it on name





























