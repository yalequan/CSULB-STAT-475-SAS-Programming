%let studentname = Yale Quan;

/* 1. Add the column of API scores to the surveyresults.sas7bdat file. 
Hint: merge the two files on SchoolName and remove all entries for which, 
say, q1 values are missing. Double-check that your resulting file contains 
the 347 schools.*/

proc contents data = tmp1.surveyresults;
run;

proc contents data = tmp1.api;
run;

* Merge and clean the data;
proc sort data = tmp1.surveyresults;
by schoolname;
run;

proc sort data = tmp1.api;
by schoolname;
run;

data combined;
  merge tmp1.surveyresults
		tmp1.api;
by schoolname;
run;

data combined;
set combined;
if q1 = "." then delete;
run;

proc print data = combined;
title1 "This table shows all schools that have a survey result";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
run;

/* 2. Impute the three missing values for q2 by the mean of the entire column. 
Hint: you should compute that mean and make it a global macro variable. */

* q2 is a character variable we need to convert it to numeric;

proc contents data = combined;
title1 "This output shows that q2 is a character variable";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
run;

data combined;
set combined;
new = input(q2, 1.);
drop q2;
rename new = q2;
run;


* Calculate the mean;
title1 "This table shows the mean for q2";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
proc means data = combined mean;
var q2;
output out = outstats mean = mean_q2;
run;

proc print data = outstats;
run;

* Create macro variable;

data _null_;
set outstats;
call symput('mean_q2', mean_q2);
run;

%put &mean_q2;

* Inpute the mean for missing values in q2 and put data back into order;

data inputed;
retain SchoolName q1 q2;
set combined;
if q2 = '.'
then q2 = &mean_q2;
run;

title1 "This table includes the imputed mean for q2 for any missing values";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
proc print data = inputed;
run;

/* 3. Compute the total of the survey results (variable “Total”). The total 
in this case is defined as the sum of q1, q2, the mean of q3a through q3h, 
reverse coded q4, q5, q6, reverse coded q7, and the mean of q8a through q8e. 
Reverse coded variable is defined by the recoding 0 into 4, 1 into 3, 2 into 
2, 3 into 1, and 4 into 0. Hint: reverse coding can be accomplished with one 
simple arithmetic operation.*/

data totaled;
set inputed;
total=q1+q2+mean(q3a,q3b,q3c, q3d, q3e, q3f, q3g, q3h)+(4-q4)+q5+q6+(4-q7)+mean(q8a,q8b,q8c,q8d,q8e);
run;
quit;

title1 "This table includes the value for total";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
proc print data = totaled;
run;

/* 4. Plot Total versus API. Present the graph. */

proc gplot data = totaled;
	title1 'Scatter Plot of Total Survey Score and School API';
	title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
	plot total * api;
	run;
quit;

/* 5. Print the school name, API, and Total for the top ten schools with the highest APIs. 
The variable Total should be formatted to show three decimal places. */

proc sort data = totaled;
	by descending api;
run;

title1 "This table shows the 10 school with the highest API score";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
proc print data = totaled (firstobs = 1 obs = 10);
format total 5.3;
run;
