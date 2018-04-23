data orders;
input ID$ order_date mmddyy8. salesperson_id$ amount;
cards;
1 8/2/12  2 540
2 1/30/12 4 1800 
3 7/14/12 1 460 
4 1/29/12 2 1100
5 2/3/13  6 600 
6 3/2/13  4 1250 
7 5/6/12  4 150 
8 4/1/13  1 1000
9 3/5/13  2 950
;

data training;
input ID$ salesperson_id$ start_date mmddyy8. 
end_date mmddyy10.;
cards;
1  1  1/1/12  12/31/12
2  1  1/1/13     .
3  2  1/1/12  7/31/12
4  2  1/1/13  5/1/13
5  3  1/1/12     .
6  4  1/1/12  12/31/12
7  5  1/1/13     .
8  6  1/1/12     .
;

data bonus;
input ID$ year tier bonus;
cards;
1 2012 750  500
2 2012 1500 1000
3 2013 850  500
4 2013 1600 1000
;

/* (a) Sales people must be trained to make orders. For a sales person 
to receive credit for an order, the order_date must fall between a training 
start and end date for that sales person. Write a query that finds all 
orders where the sales person did not have an active training on the order 
date. */

proc sql;
create table exclude as
 select a.salesperson_id, a.order_date 
    format mmddyy8., a.amount
   from orders as a
    full join
  training as b
   on a.salesperson_id=b.salesperson_id
    where (a.order_date>b.start_date and
	(a.order_date<b.end_date or b.end_date=.));
 select * from exclude;
   quit;

   proc sql;
   select a.salesperson_id, a.order_date
   format mmddyy8., a.amount
    from orders as a
    except
	select b.salesperson_id, b.order_date 
      format mmddyy8., b.amount
	 from exclude as b;
	quit;

/* (b) The sales person gets a bonus pay if their 
	amount exceeds a certain tier level for each year. 
	Write a query that shows who would be getting a 
bonus and for how much. */

proc sql;
create table sales as
select a.ID, a.salesperson_id, a.order_date format mmddyy8., a.amount, 
       b.bonus
	  from orders as a
	   right join
	   bonus as b
on year(a.order_date)=b.year and a.amount>b.tier
 where a.amount ne .;
select distinct ID, salesperson_id, order_date, amount, max(bonus) as bonus from sales
group by salesperson_id, order_date;
quit;

	    
