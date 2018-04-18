data record;
input ID$ Gender$ Age Score;
cards;
259632	F	56	58
259632	F	56	41
259632	F	56	39
577763	F	67	40
577763	F	67	50
577763	F	67	39
577763	F	67	33
279645	M	52	24
279645	M	52	65
279645	M	52	66
279645	M	52	74
279645	M	52	85
694797	F	48	37
694797	F	48	85
684516	M	57	81
760076	M	62	45
760076	M	62	35
760076	M	62	38
760076	M	62	65
745795	F	74	85
745795	F	74	82
745795	F	74	77
745795	F	74	81
506301	M	78	70
506301	M	78	70
506301	M	78	71
506301	M	78	67
406126	M	62	60
406126	M	62	50
477908	M	70	50
477908	M	70	63
477908	M	70	51
;
/* (a) How many patients? 

10 patients
*/

proc sql;
select count (distinct ID) as IDcount
	from record;
quit;



/* (b) How many patients by gender?


Female = 4
Male = 6

*/

proc sql;
select gender, count (distinct ID) as IDCount
	from record
		group by gender;
quit;


/* (c) How many patients older than
   65? 

4 patients are older then 65

*/

proc sql;
select count (distinct ID) as OldCount
	from record
		where age > 65;
quit;




/* (d) How many women older than 65?


2 patients are female older then 65

*/

proc sql;
select count (distinct ID) as Femaleold
	from record
		where (gender = 'F' and age > 65);
quit;

/* (e) How many doctor visits for each
patient? 

ID nvisits 
259632 3 
279645 5 
406126 2 
477908 3 
506301 4 
577763 4 
684516 1 
694797 2 
745795 4 
760076 4 

*/

proc sql;
select ID, count (*) as nvisits
	from record
		group by ID;
quit;

/*  (e.2) How many patients had 1, 2, 3, etc. visits? 


                                       nvisits  npatients
                                      -------------------
                                             1          1
                                             2          2
                                             3          2
                                             4          4
                                             5          1

*/

proc sql;
create table visits as /* create a data set to count visits */
select ID, count (*) as nvisits
	from record
		group by ID;
quit;

proc sql;
select nvisits, count (*) as npatients
	from visits
		group by nvisits;
quit;


/* (f) How many doctor visits for each
patient with medical test score above 
50? 


                                       ID         nvisist
                                       ------------------
                                       259632           1
                                       279645           4
                                       406126           1
                                       477908           2
                                       506301           4
                                       684516           1
                                       694797           1
                                       745795           4
                                       760076           1



*/

proc sql;
select ID, count (*) as nvisist
	from record where score > 50
	group by ID;
quit;



/*(g) What are minimum, mean, and
maximum scores for each patient? 

                            ID        minscore  meanscore  maxscore
                            ---------------------------------------
                            259632          39         46        58
                            279645          24       62.8        85
                            406126          50         55        60
                            477908          50   54.66667        63
                            506301          67       69.5        71
                            577763          33       40.5        50
                            684516          81         81        81
                            694797          37         61        85
                            745795          77      81.25        85
                            760076          35      45.75        65 


*/

proc sql;
select ID, min(score) as minscore, mean(score) as meanscore, max(score) as maxscore
from record
	group by ID;
quit;


/* (h) List patients who have mean 
scores for all their visits larger 
than 60


                                      ID        meanscore
                                      -------------------
                                      279645         62.8
                                      506301         69.5
                                      684516           81
                                      694797           61
                                      745795        81.25

*/

proc sql;
select ID, mean(score) as meanscore
	from record
		group by ID
			 having meanscore > 60;
quit;
		

