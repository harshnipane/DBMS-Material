
{
"_id" : 4,
"title" : "Flex 3 in Action",
"isbn" : "1933988746",
"pageCount" : 576,
"publishedDate" : ISODate("2009-02-02T08:00:00Z"),

"thumbnailUrl" : "https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-
thumb-images/ahmed.jpg",

"longDescription" : "New web applications require engaging user-friendly interfaces
he complexity of your projects increases.",
"status" : "PUBLISH",
"authors" : [
"Tariq Ahmed with Jon Hirschi",
"Faisal Abid"
],
"categories" : ["Internet"]
}



--1 Find all books whose author is Faisal Abid and display name of book authors and categories
db.book.aggregate([
{$match:{authors:'Faisal Abid'}},
{$project:{authors:1,categories:1}}
])


--2 List all the books with category Internet at first position in category array
db.book.find({'categories.0':'Internet'})



--3 Change the status of books “undergoing change” for books having more than 500 pages and published in 2009
db.book.update({pageCount:{$gt:500},$expr:{$eq:[{$year:'$publishedDate'},2009]}},{$set:{status:'undergoing change'}})



--4 Find all the books containing word highlighting and depth in long description of the book
db.book.find({longDescription:/web.*projects/})



--5 Display all books published in 2009
db.book.find({$expr:{$eq:[{$year:'publishedDate'},2009]}});



--6 Find all books with pageCount is either 500 or 556 or 670
db.book.find({pageCount:{$in:[500,556,670]}});


--7 Add 2 categories “kindle” and “hard bind” in all the books if its pageCount >200 and
--< 500 or number of pages >500
db.book.find({pageCount:{$gt:200,$lt:500}},{$push:{categories:{$each:['kindel','hard bind']}}});


--8 List all the books which has thumbnailUrl key
db.book.find({thumbnailUrl:{$exists:true}}).count()



--9 Add key type with values [“fiction”,”moral stories”,”adventurous”] in all books
--whose title starts with Fl and contains a some where in the name
db.book.update({title:/^Fl.*a.*/},{$set:{key:['fiction','moral stories','adventurous']}},{multi:true})



--10 Add a key comments :[{comment:” like the book” ,date:ISODate(“2019-09-01”)},
db.book.updateMany({},{$set:{comments :{comment:"like the book",date:new Date()}}});



--11 Add new author “myauthor” at position 2 for all books whose title starts with h or m
--and contains s at 2nd last position
db.book.updateMany({title:/^[HM].*s.$/},{$push:{authors:'myauthor',$position:1}})



--12 Increase pageCount by 100 for all books whose author at 1 st position is “Gal Shachor”
db.book.updateMany({'authors.0':'Gal Shachor'},{$inc:{pageCount:100}});



--13 Overwrite “Magnus Rydin" with name “Fr”
db.employee.updateMany({"authors": "Magnus Rydin" },{$set:{"authors.$[element]": "Fr" }},{arrayFilters: [{ "element": "Magnus Rydin" }] });



--14 List all books title, status, pageCount, comments for all books with pages > 300 or <
--500 or title starts with a or isbn starts with 193
db.book.find({$or:[{pageCount:{$gt:300,$lt:500}},{title:/^A/},{isbn:/^193/}]},{title:1,status:1,pageCount:1,comments:1})


--Q2
--1
db.book.aggregate([
{$project:{pagecount:{$add:[{$multiply:['$pageCount',100]},{$multiply:['$pageCount',0.7]}]}}},
{$match:{isbn:/^193.*/}}])

--2
db.book.aggregate([
{$project:{bookcode:{$concat:[{$substr:['$title',0,3]},{$substr:['$isbn',4,3]}]}}}]);

--3
db.book.aggregate([
{$group:{_id:null,sump:{$sum:'$pageCount'},maxp:{$max:'$pageCount'},minp:{$min:'$pageCount'},avgp:{$avg:'$pageCount'}}}]);

--4
db.book.aggregate([
{$group:{_id:'$categories',sump:{$sum:'$pageCount'},maxp:{$max:'$pageCount'},minp:{$min:'$pageCount'},avgp:{$avg:'$pageCount'},count:{$sum:1}}},
{$sort:{count:1}}
])

--5
db.book.find({authors:'Faisal Abid'},{title:1,pageCount:1});


--6
db.book.update({})


--7
db.book.find({})

--8
db.book.aggregate([
{$project:{title:1,isbn:1,pageCount:1}},
{$sort:{pageCount:-1}},
{$skip:2},
{$limit:3},
{$sort:{title:1}}
])


--9
db.book.aggregate([
{$group:{_id:'$categories',sump:{$sum:'$pageCount'}}},
{$match:{title:/[am]/,isbn:/7/}}
])

{$match:{title:/.*[am].*/,isbn:/.*7/}}