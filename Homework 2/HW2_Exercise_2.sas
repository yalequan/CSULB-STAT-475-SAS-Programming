proc import out=exercise2
datafile = 'C:\Users\yaleq\iCloudDrive\Documents\School\CSULB\CSULB - MATH\STAT 475 - SAS Programming\HW2\Exam_Ex2.xlsx'
dbms=xlsx replace;
run;
/*
proc contents varnum;
run;
*/
title;
options nonumber nodate;

proc report nowd headline headskip;
column State_Name State_Abbrev_  Postal_Abbrev_  Area__Sq_Mi_ Population;
define State_Name/ 'State Name';
define State_Abbrev_ / width = 8 'State/Abbrev.';
define Postal_Abbrev_ / width = 7 spacing = 10 'Postal/Abbrev.';
define Area__Sq_Mi_ / format=comma7.0 'Area/(Sq Mi)';
define Population / format=comma10.0 'Population';
run;
