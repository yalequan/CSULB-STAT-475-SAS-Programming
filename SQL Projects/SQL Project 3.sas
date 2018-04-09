data visit1;
input ID$ visit_date mmddyy8. @19 bdate 
mmddyy8. race$	score;
cards;
198650  11/28/11  04/29/87 Hispanic  24
232738  09/19/11  03/22/54 Hispanic  33
233880  09/23/11  05/15/67 White  	 74
234127  11/07/11  07/03/72 Black  	 85
234152  09/27/11  11/08/50 Hispanic  28
234385  09/15/11  06/06/68 Black 	 85
;

data visit2;
input ID$ @9 visit_date mmddyy8. score;
cards;
232738  10/18/11  66
233880  09/26/11  37
234127  12/16/11  85
234152  01/10/12  38
;

data visit3;
input ID$ @9 visit_date mmddyy8. score;
cards;
232738  10/29/11  75
234127	12/29/11  45
234152	02/27/11  35
;

/* (a) Combine the three data sets into one file that contains one 
row per person, and variables: id, bdate, race, visit1_date, visit1_score, 
visit2_date, visit2_score, visit3_date, and visit3_score*/

proc sql;
create table temp as 
select a.id, a.bdate, a.race, a.visit_date as visit1_date, a.score as visit1_score, b.visit_date as visit2_date, 
b.score as visit2_score /*rename variables*/
	from visit1 as a
	left join
	visit2 as b
	on visit1.id = visit2.id;
quit;

proc sql;
select a.id, a.bdate format mmddyy8., a.race, a.visit1_date format mmddyy8., a.visit1_score, a.visit2_date format mmddyy8., 
a.visit2_score, b.visit_date as visit3_date format mmddyy8., b.score as visit3_score format mmddyy8./*rename variables*/
	from temp as a
	left join
	visit3 as b
	on temp.id = visit3.id;
quit;

/* Another way to solve this*/

proc sql;
select a.id, a.bdate format mmddyy8., a.race, a.visit_date as visit1_date format mmddyy8., a.score as visit1_score, 
b.visit_date as visit2_date format mmddyy8.,  b.score as visit2_score, 
c.visit_date as visit3_date format mmddyy8., c.score as visit3_score  /*rename variables*/
	from visit1 as a
	left join
		visit2 as b
		on visit1.id = visit2.id
	left join 
		visit3 as c
		on visit1.id = visit3.id;
quit;



/* (b) Combine the three data sets into one long-form data set with variables
ID, bdate, race, visit_date, score */

proc sql;
select ID, visit_date format mmddyy8., score, bdate format mmddyy8., race
	from visit1
	union
		select ID, visit_date format mmddyy8., score from visit2
	union
		select ID, visit_date format mmddyy8., score from visit3;
quit;
