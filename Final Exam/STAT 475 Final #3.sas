/* Problem 3. Consider the dataset in file Products.dat. 
The variables are Product Number, Product Name, Manufacturer 
Number, Product Type and Retail Unit Cost. Do the following */


* (a) Read instream data;


%let studentname = Yale Quan;


data products;
input prodnum 1-4 prodname$ 6-27 manunum 29-31 prodtype$ 33-43 rtlcost comma7.;
cards;
5009 Dream Machine	        500 Workstation $3,200 
4506 Business Machine       450	Workstation	$3,345 
2101 Travel Laptop	        400 Laptop	    $2,760 
2212 Analog Cell Phone	    230	Phone	    $35 
4509 Digital Cell Phone 	245	Phone	    $175 
5003 Office Phone	        560	Phone	    $145 
1110 Spreadsheet Software   134 Software	$300 
1200 Database Software	    113 Software	$799 
3409 Statistical Software   243	Software	$1,899 
2102 Wordprocessor Software 245 Software	$345 
2200 Graphics Software	    246	Software	$599 
;

proc print data = products;
title1 "Confirming correct instream data";
title2 "Assignment completed by &studentname on &SYSDATE at &SYSTIME";
run;

proc contents varnum data = products;
title1 "Confirming correct instream data";
title2 "Assignment completed by &studentname on &SYSDATE at &SYSTIME";
run;

* (b) Use PROC SQL to insert a new row
  prodnum     prodname      manunum   prodtype     rtlcost
  3480   Desktop Computer    780    Workstation    $1,799
;

proc sql;
title1 "This table creates a pricelist table from instream data and adds a row";
title2 "Assignment completed by &studentname on &SYSDATE at &SYSTIME";
create table pricelist as
select * 
from products;
insert into pricelist
values (3840, 'Desktop Computer', 780, 'Workstation' 1799);
select *
from pricelist;
quit;

* (c)	Use PROC SQL to modify the data to reflect a 20% price 
increase on all software products, and a 20% discount on all 
the other products.;

proc sql;
title1 "This table reflects a 20% price increase on Software and a 20% discount on all others";
title2 "Assignment completed by &studentname on &SYSDATE at &SYSTIME";
create table pricechange as
select * 
from pricelist;
update pricechange
	set rtlcost = rtlcost * 1.20
	where prodtype = 'Software';
update pricechange
	set rtlcost = rtlcost - (rtlcost * .20)
	where prodtype ne 'Software';
select *
from pricechange;
quit;

* (d)	Use PROC SQL to add title, footnote, labels and modify 
formats (if necessary);

proc sql;
title1 "Product Information";
title2 "Assignment completed by &studentname on &SYSDATE at &SYSTIME";
footnote "Updated on &SYSDATE";
alter table pricechange
	modify rtlcost format = dollar10.2 label = "Retail Unit Cost";
alter table pricechange
	modify prodnum label = "Product Number";
alter table pricechange
	modify prodname label = "Product Name";
alter table pricechange
	modify manunum label = "Manufacturer Number";
alter table pricechange
	modify prodtype label = "Product Type";   
select * from pricechange;
quit;
