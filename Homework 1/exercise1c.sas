proc import out=exercise1c
datafile = 'C:\Users\yaleq\iCloudDrive\Documents\School\CSULB\CSULB - MATH\STAT 475 - SAS Programming\HW1\NBA.csv'
dbms = csv replace;
run;
proc print;
run;
