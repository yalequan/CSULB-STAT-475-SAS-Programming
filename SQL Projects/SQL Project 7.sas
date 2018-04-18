data race2017;
input groupplace overall gender$ @10 name$ 23. age time time5.;
cards;
1   1  M Vliet, Sven             24 14:37
1   2  M Van Der Ocampo, Rogelio 36 15:02
1   3  M Botello, Dylan          14 16:17
2   4  M Whelan, Jerry           15 16:24
1   5  F Mitchel, Elin           16 17:44
14 169 F Hatch, Erin             48 44:27
;
proc print;
format time time5.;
run;

/* Create a table just like this one to store race results for 2018 run.  
Populate the empty results table with the following three top-place winners:
1 1 M Appell, Johann 33 16:28
2 2 M Torres, Jorge  31 17:29
1 3 M Fuller, Rufus  21 17:45
*/

proc sql;
create table race2018 like race2017;
	insert into race2018 (groupplace, overall, gender, name, age, time)
	values (1, 1, 'M', 'Appell, Johann', 33, '16:28'T)
	values (2, 2, 'M', 'Torres, Jorge',  31, '17:29'T)
	values (1,3, 'M', 'Fuller, Rufus',  21, '17:45'T);
select groupplace, overall, gender, name, age, time format time5. from race2018;
quit;
