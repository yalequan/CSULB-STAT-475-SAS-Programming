proc import out = exercise1 (drop = ID) /* drop ID variable.  Not used */
datafile = 'C:\Users\Yale Quan\iCloudDrive\Documents\School\CSULB\CSULB - MATH\STAT 475 - SAS Programming\Midterm1\Exam_Ex1.csv'
dbms = csv replace;
run;
/*
proc contents varnum;
run;
*/

ods html body = 'C:\Users\Yale Quan\iCloudDrive\Desktop\outdata_Ex1.html';

proc means n mean median std min max range maxdec = 2;
	Label Age = 'Age'
		  Visit_1 = 'Visit 1'
		  Visit_2 = 'Visit 2'
		  Visit_3 = 'Visit 3'
		  Visit_4 = 'Visit 4';
	class Group; /*Group proc means by group designation*/
	run;
ods html close;

