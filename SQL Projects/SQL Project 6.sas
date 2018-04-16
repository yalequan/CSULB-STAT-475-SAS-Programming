data ids;
input student_id survey_id;
cards;
1001	17933
1002	17822
1003	18201
2001	19993
2002	17333
2004	16452
;

data survey;
input survey_id	q1;
cards;
17933	4
18201	3
17333	5
16452	5
;

data demo;
input student_id gpa;
cards;
1001	3.99
1002	3.77
1003	2.98
2001	3.75
2002	3.45
2004	2.75
;

/* (a) Study the statements below and note the
exact output it produces. */

proc sort data=ids;
by survey_id;
run;

proc sort data=survey;
by survey_id;
run;

data one;
merge ids survey;
by survey_id;
run;

proc sort data=one;
by student_id;
run;

proc sort data=demo;
by student_id;

data two;
merge one demo;
by student_id;
run;

data cleaned;
set two;
if (q1 ne '.');
run;

proc print data=cleaned;
run;

/* (b) Produce the exact same output in a single
proc sql statement. */

proc sql;
create table student_info as
select ids.student_id, ids.survey_id, demo.gpa from ids
	right join
	demo
		on ids.student_id=demo.student_id;
create table complete_survey as
select * from student_info
right join
survey
on student_info.survey_id = survey.survey_id;
select * from complete_survey order by student_id;
quit;
