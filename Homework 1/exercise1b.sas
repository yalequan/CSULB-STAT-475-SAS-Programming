data NBA;
infile 'C:\Users\yaleq\iCloudDrive\Documents\School\CSULB\CSULB - MATH\STAT 475 - SAS Programming\HW1\NBA.dat';
input Team $ 1-12 Attendance Price;
run;

proc print data=NBA;
run;
