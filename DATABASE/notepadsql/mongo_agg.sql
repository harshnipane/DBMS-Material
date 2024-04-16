----Aggregate is advance filter function

$group ---> it provides all aggregate functions ($sum,$avg,$min,$max)
$project--->will help you to generate derived columns and display only 
    few kesys
$match----> this filter helps to select few documents
        based on condition, all conditions we used in find can be 
	    used in $match
$sort---> sort the data in ascending or descending order
$limit----> will select few documents
$skip---> will skip few documents
$unwind---> to unwind the arrays



------find 3rd and 4 th and  5th lowest rating arranged on name
db.movie.aggreagate([
{$sort:{rating:1}},
{$skip:2},
{$limit:3},
{$sort:{name:1}}
])




------find name,rating, price of 3rd and 4 th and  5th 
-----lowest rating arranged on name
db.movie.aggregate([
{$sort:{rating:1}},
{$skip:2},
{$limit:3},
{$sort:{name:1}},
{$project:{name:1,rating:1,price:1,_id:0}}
])



------find name,rating, price, 
and addition of rating and price of 3rd and 4 th and  5th 
-----lowest rating arranged on name
db.movie.aggregate([
{$sort:{rating:1}},
{$skip:2},
{$limit:3},
{$sort:{name:1}},
{$project:{name:1,rating:1,price:1,
addition:{$add:['$rating','$price']},_id:0}}
])




----$project---
 operators on number
$add:[expr1,[expr2,exp3,…….]]]
$subtract : [expr1,expr2]       ---- expr1-expr2
$multiply:[expr1,[expr2,exp3,…….]]
$divide:[ expr1,expr2]
$mod: [expr1,expr2]
$round:[value, 2]

{$ifNull:['$price',0]}
 
 
 
 
 operators on String
$toUpper-----convert to upper case
$toLower ------convert to lower case
$concat:[str,str2,str3]
$substr:[str,start,end]



operators  on date
$year
$month
$day
$hour
$minute




---display name,actor,rating,price,ticket_no, 
also display sum of ticket_no and price; 

db.movie.aggregate([
{$project:{name:1,price:1,ticket_no:1,
rating:1,sump:{$add:[{$ifNull:['$price',0]},
{$ifNull:['$ticket_no',0]}]}}}])




-----display name in capital, price, ticket_no, and 
difference between price and ticketnum
if price and ticket no are not null


price:{$nin:[null],exists:true}
ticket_no:{$nin:[null],exists:true}


db.movie.aggregate([
{$match:{price:{$nin:[null],$exists:true},
ticket_no:{$nin:[null],$exists:true}}},
{$project:{name:{$toUpper:'$name'},price:1,
ticket_no:1,
differ:{$subtract:['$price','$ticket_no']}}}
])




-----find discountprice for all movies with rating >=3, 
-----if the discount is 10% 
price=1*price-0.10*price
$subtract:['$price',{$multiply:['$price',0.10]}]

price(1-0.10)
price*0.90


$multiply:['$price',0.90]
$subtract:['$price',{$multiply:['$price',0.10]}]



db.movie.aggregate([
{$match:{rating:{$gte:3}}},
{$project:{name:1,price:1,rating:1,
discount1:{$multiply:['$price',0.90]},
discount2:{$subtract:['$price',
                     {$multiply:['$price',0.10]}]}
}}
])




-----display name in upper case and display 
--code for movie, code is first 3 aplphabets of movie
db.movie.aggregate([
{$project:{name:{$toUpper:'$name'},price:1,
mcode:{$substr:['$name',0,3]}}}
])




------display all movies and display how many 
years ago they are releases
db.movie.aggregate([
{$project:{name:1,rating:1,
release_date:1,ryear:{$year:'$rdate'}}},
{$project:{name:1,rating:1,rdate:1,ryear:1,
numy:{$subtract:[{$year:new Date()},'$ryear']}}}
])




----display sum of price, max price, min price
db.movie.aggregate([
  {$group:{_id:null,sump:{$sum:'$price'},
  minp:{$min:'$price'},maxp:{$max:'$price'},
  count:{$sum:1}}}
])




----display sum of price, max price, min price and count 
---ratingwise
db.movie.aggregate([
  {$group:{_id:'$rating',sump:{$sum:'$price'},
  minp:{$min:'$price'},maxp:{$max:'$price'},
  count:{$sum:1},avgp:{$avg:'$price'}}}
])




db.movie.aggregate([
{ $group: { _id: '$rating', 
sump: { $sum: '$price' }, 
minp: { $min: '$price' }, maxp: { $max: '$price' },
 count: { $sum: 1 } } },{$sort:{_id:-1}},{$limit:2}]);
 
 
 
 
------display all rating in which more than 3 movies 
------are there
db.movie.aggregate([
{ $group: { _id: '$rating', 
sump: { $sum: '$price' }, 
minp: { $min: '$price' }, maxp: { $max: '$price' },
 count: { $sum: 1 } } },
 {$sort:{_id:-1}},{$match:{count:{$gte:3}}}]);




-------find sum of all prices rating wise but display
 only if the sum is >600
 
 
db.movie.aggregate([
{$group:{_id:'$rating',sump:{$sum:'$price'}}},
{$match:{sump:{$gt:600}}}
])




---display name, address,email for all student 
----as name followed  by ., followed by 
first 3 letters of name,followed by @mycompany.com
ashish.ash@mycompany.com

db.student.aggregate([
{$project:{name:1,address:1,
email:{$concat:['$name','.',
      {$substr:['$name',0,3]},'@mycompany.com']}}}
])




----find experience of employee

db.employee.aggregate([
{$project:{name:1,hiredate:1,yearj:{$year:'$hiredate'}}},
{$project:{name:1,hiredate:1,yearj:1,
experience:{$subtract:[{$year:new Date()},'$yearj']}}}])




---find 3 movies which ticket prices are hisghest 
--arrange it on name
db.movie.aggregate([
 {$sort:{price:-1}},
 {$limit:3},
 {$sort:{name:1}}
 
])






---find 3 rd 4th and 5 th highest rating's, 
--sum and average of prices for each rating


 db.movie.aggregate([
 { $group:{_id:'$rating',sump:{$sum:'$price'},
 avgp:{$avg:'$price'}}},
 {$sort:{_id:-1}},
 {$skip:2},
 {$limit:3}]);