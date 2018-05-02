/* Exercise 3.  Write a SAS code to compute 1+1. Your code must contain the following keywords:

title 
assignment is completed by
&sysday
&sysdate
&systime
Your full name
%scan to extract your last name
%eval
%let
%put
%macro
%mend

*/

%let fullname = Yale Quan;
%let lastname = %scan(&fullname, 2);
%let i=1;
%let count=%eval(&i+&i);
%put &count;


data grades;
  input id$ quiz1 hw1 exam1 quiz2 hw2 exam2;
cards;
0495 94 97 95 94 100 97
8612 89 92 82 97 100 88
6236 94 89 85 91  94 86
;

%macro printmacro (dataset);
	title1 "This assignment is completed by &lastname on &sysday, &sysdate, on &systime";
	title2 "&i + &i = &count";
     options nodate nonumber;
  proc print data=&dataset;
  run;
%mend;

%printmacro(grades)
