/*
Exercise 1. (Use proc sql) The files grades550.xls, grades484.xls, and grades695.xls contain student ids 
and their final grades. 
*/

libname desktop 'C:\Users\yaleq\Desktop\'; *This creates a SAS datset on the desktop on the PC;

proc import out=desktop.grades550
 datafile = 'C:\Users\yaleq\Desktop\grades550.xlsx'
 dbms = xlsx replace;
 run;

 proc import out=desktop.grades484
 datafile = 'C:\Users\yaleq\Desktop\grades484.xlsx'
 dbms = xlsx replace;
 run;

 proc import out=desktop.grades695
 datafile = 'C:\Users\yaleq\Desktop\grades695.xlsx'
 dbms = xlsx replace;
 run;

*(a)How many students took STAT550 and STAT484 at the same time? What were their grades in these courses? 
 List their ids and respective grades.;

 proc sql number;
 select a.id, a.grade label = 'grade550', b.grade label = 'grade484' 
	from tmp1.grades550 as a, tmp1.grades484 as b
 	where a.id=b.id;
	quit;

/*                                   Row       ID  grade550  grade484
                               ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                                    1          6718  A         A
                                    2          2272  A         B
                                    3          6056  A         A
                                    4          8266  A         A
                                    5          7756  A         A
                                    6          3406  A         A
                                    7           384  A         A
                                    8          6346  A         A
                                    9          5310  B         C
                                   10          8219  B         B
                                   11          8991  B         B
                                   12          3598  B         B
                                   13           495  B         B
*/

*(b) How many students took STAT550 and STAT695 at the same time? What were their grades in these courses? 
	List their ids and respective grades.;

 proc sql number;
 select a.id, a.grade label = 'grade550', b.grade label = 'grade695' 
	from tmp1.grades550 as a, tmp1.grades695 as b
 	where a.id=b.id;
	quit;

/*                                Row            ID  grade550  grade695
                               ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                                    1          3528  A         A
                                    2          4852  A         A
                                    3          7577  A         A
                                    4          1455  A         A
                                    5           477  A         A
                                    6          7756  A         A
                                    7          3406  A         A
                                    8          1841  A         A
                                    9          1401  A         B
                                   10          5967  A         A
                                   11          3572  A         B
                                   12          5310  B         B

	*/

*(c) How many students took STAT484 and STAT695 at the same time? What were their grades in these courses? 
	 List their ids and respective grades.;
 proc sql number;
 select a.id, a.grade label = 'grade484', b.grade label = 'grade695' 
	from tmp1.grades484 as a, tmp1.grades695 as b
 	where a.id=b.id;
	quit;

/*        							Row        ID  grade484  grade695
                               ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                                    1          7756  A         A
                                    2          3406  A         A
                                    3          8407  A         A
                                    4          2267  A         A
                                    5          6306  A         A
                                    6          5310  C         B

	*/

*(d) How many students took all three courses at the same time? What were their grades in these courses? 
	 List their idfs and respective grades?;

proc sql number;
 select a.id, a.grade label = 'grade484', b.grade label = 'grade695', c.grade label = 'grade550' 
	from tmp1.grades484 as a, tmp1.grades695 as b, tmp1.grades550 as c
 	where a.id=b.id=c.id;
	quit;

/* 
	               			Row            ID  grade484  grade695  grade550
                          ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                               1          7756  A         A         A
                               2          3406  A         A         A
                               3          5310  C         B         B
*/
