data painscores; 
input id mos3 mos6 mos12 mos24 mos36;
cards;
 1 	46	57	67	68	75
 2 	24	35	.	.	.
 3 	30	45	58	.   .
 4 	22	.	48	66	76
 5 	18	15	14	.	.
 6 	35	67	.   .   .
 7 	27	47	50	55	67
 8 	12	31	41	47	52
 9 	55	76	.	.	.
10 	18	39	50	67	78
11 	10	25	28	33	33
12 	35	44	67	.    .
13 	22	45	.	68	78
14 	35	55	70	75	83
;
/* make a long-form data set */

data longform;
set painscores;
	array m [5] (3 6 12 24 26); /*Array for the months */
	array s [5] mos3 mos6 mos12 mos24 mos36; /*Array for scores.  Pull values from initial dataset*/
		do i = 1 to 5;
			month = m[i];
			score = s[i];
		   output;
		end;
		keep id month score;
run;

proc print noobs data = longform;
run;


/* remove all missing values */

data longform;
set longform;
	if (score ne .);
run;

proc print noobs data = longform;
run;

/* compute the number of visits per patient */

proc sql;
select id, count(*) as nvisits /*Counting rows */
	from  longform
	group by id;
quit;

	

/* compute the number of patients who had 1, 2, 3,
etc. visits */

proc sql;
create table visits as /*create data set from above sql query */
select id, count(*) as nvisits /*Counting rows */
	from  longform
	group by id;
	select * from visits;
quit;

proc sql;
select nvisits, count (*) as npatients
	from visits
	group by nvisits;
quit;

