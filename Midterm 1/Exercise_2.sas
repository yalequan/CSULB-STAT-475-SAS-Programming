proc import out= exercise2 (drop = ID)
datafile = 'C:\Users\yaleq\iCloudDrive\Documents\School\CSULB\CSULB - MATH\STAT 475 - SAS Programming\Midterm1\Exam_Ex2.csv'
dbms = csv replace;
run;
/*
proc contents varnum;
run;

*/

ods html body = 'C:\Users\yaleq\iCloudDrive\Desktop\outdata_Ex2.html';

proc freq;
tables A*B;
run;

ods html close;
