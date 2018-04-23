/*
Exercise 2. (Use proc sql) File glaucoma.xls contains data on patients who underwent a glaucoma treatment 
in one of two eyes (Tx group), the other eye was kept as a control (Cx group). 
The other variables are number of medications (No of meds), Time previously on medication (in years), Sex, Age, 
and Type of glaucoma
*/

libname desktop 'C:\Users\yaleq\Desktop\';

proc import out=desktop.glaucoma
 datafile = 'C:\Users\yaleq\Desktop\glaucoma.xlsx'
 dbms = xlsx replace;
 run;

proc sql number;
delete from tmp1.glaucoma
where id = .;
select * from tmp1.glaucoma;
quit;

*(a) How many patients were in the study?;

proc sql;
select count (distinct ID) as npatient
	from tmp1.glaucoma;
quit;

/* 											   npatient
                                               ƒƒƒƒƒƒƒƒ
                                                 26
*/


*(b) How many patients were currently on medication? 
     How many were currently off medication or medication-naive (never took medication)?;
proc sql;
select count (distinct ID) as patients_on_medication
	from tmp1.glaucoma
where nmeds>0;
quit;

/* 											patients_on_
                                               medication
                                            ƒƒƒƒƒƒƒƒƒƒƒƒƒ
                                                       17
*/
proc sql;
select count (distinct ID) as patients_off_medication
	from tmp1.glaucoma
where nmeds=0;
quit;

/* 											patients_off_
                                             medication
                                            ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                                                         9
*/

*(c) What were the mean, standard deviation, min, and max 
     of the time previously on medication? Exclude medication-naive patients.;

proc sql;
title 'Mean, STD, Min, and Max of patients who are on medication';
select distinct id, nmeds, avg(nmeds)as avg_nmeds, std(nmeds) as std_meds, min(nmeds) as min_nmeds, max(nmeds) as max_nmeds 
from tmp1.glaucoma
where nmeds > 0;
quit;

/* 
       					   ID         nmeds  avg_nmeds  std_meds  min_nmeds  max_nmeds
                ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                          71             1   1.294118  0.462497          1          2
                          83             1   1.294118  0.462497          1          2
                          92             1   1.294118  0.462497          1          2
                          95             2   1.294118  0.462497          1          2
                          98             1   1.294118  0.462497          1          2
                         102             1   1.294118  0.462497          1          2
                         103             1   1.294118  0.462497          1          2
                         108             2   1.294118  0.462497          1          2
                         109             1   1.294118  0.462497          1          2
                         112             1   1.294118  0.462497          1          2
                         113             1   1.294118  0.462497          1          2
                         114             1   1.294118  0.462497          1          2
                         115             1   1.294118  0.462497          1          2
                         116             2   1.294118  0.462497          1          2
                         117             2   1.294118  0.462497          1          2
                         120             1   1.294118  0.462497          1          2
                         130             2   1.294118  0.462497          1          2
*/


*(d) How many males and how many females were in the study?;

proc sql;
title 'Patients in study by gender';
select sex, count (distinct id) as npatient
from tmp1.glaucoma
group by sex;
quit;

/*
                                            Sex  npatient
                                            ƒƒƒƒƒƒƒƒƒƒƒƒƒ
                                            F           8
                                            M          18

*/

*(e) How many patients were in the study by type of glaucoma?;

proc sql;
title 'Amount of Patients With Glaucoma Type';
select glaucoma, count (distinct id) as npatient
from tmp1.glaucoma
group by glaucoma;
quit;

/*
                                   	    glaucoma      npatient
                                        ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                                        POAG                10
                                        normotensive        12
                                        pigmentary           3
                                        traumatic            1

*/

*(f) What was the mean age by gender and type of glaucoma?;

proc sql;
title 'Average age of patient by gender and glaucoma type';
select sex, glaucoma, avg(age) as avg_age format comma.2
from tmp1.glaucoma
group by sex, glaucoma;
quit;
