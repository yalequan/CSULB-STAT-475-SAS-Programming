data stat482;
input id$ hw1 hw2 exam1 hw3 @@;
cards;
0144 57  95  52  94   0898 93  95  95  95
1294 98  100 100 100  1401 98  100 90  99
1460 86  98  85  98   1510 97  100 92  91
1618 98  0   59  100  1620 82  100 56  100
1700 100 100 76  94   2237 41  10  55  95
2694 90  100 61  88   2977 97  100 90  99
3345 29  82  68  0    3357 96  100 68  98
3534 90  90  73  95   3593 100 100 95  100
3640 92  95  54  93   4003 97  98  66  99
4276 87  100 85  97   4336 95  100 83  97
4360 92  100 100 97   4432 97  100 90  100
5393 100 100 78  99   5519 97  100 100 100
6513 100 100 80  98   7083 100 100 83  100
7143 100 100 93  97   7174 99  100 95  100
7521 95  100 81  95   7566 100 94  50  84
7619 91  100 76  100  7964 97  100 83  97
9083 95  100 85  100  9197 98  88  70  91
9267 91  90  29  95   9592 79  65  35  80
9603 92  100 90  97
;

data stat475;
input id$ hw1 hw2 exam @@;
cards;
0529 98  89  95   0646 100 97  100
0880 90  89  93   1618 98  95  85
2787 98  100 95   3088 95  100 95
3181 98  100 100  3300 98  100 97
3593 98  97  100  3640 98  97  97
4184 100 100 97   4336 95  100 100
4441 98  100 100  4691 100 100 90
4767 98  97  99   4822 96  95  97
4938 91  100 94   5352 98  100 92
5393 98  100 98   6129 100 95  97
6513 98  100 100  6542 100 87  98
7083 93  78  84   7398 100 97  97
8377 95  89  80   9044 90  100 97
9267 95  97  97
;

/*(a) List all students who are in both
classes: their id's and all their grades */

proc sql;
select a.id, a.hw1 as hw1_482, a.hw2 as hw2_482, a.exam1 as exam1_482, a.hw3 as hw3_482, b.hw1 as hw1_475, b.hw2 as hw2_475,
b.exam as exam_475
from stat482 as a
inner join
stat475 as b
	on a.id = b.id;
quit;

/* another way to solve */

proc sql;
select a.id, a.hw1 as hw1_482, a.hw2 as hw2_482, a.exam1 as exam1_482, a.hw3 as hw3_482, b.hw1 as hw1_475, b.hw2 as hw2_475,
b.exam as exam_475
from stat482 as a, stat475 as b
	where a.id = b.id;
quit;

/* (b) Find the best student in either class. Assume that
in STAT 482, hws are worth 60pts, exams are worth 100
points; in STAT 475, hws are worth 25 points, and exams are worth 100 points,
and the given scores are percent of maximum possible.*/

proc sql;
create table stat482 as /* Adding new variable to existing table */
select id, hw1, hw2, exam1, hw3, ((hw1 + hw2 + hw3) * 0.6 + exam1)/(60 * 3 + 100) * 100 as total
	from stat482;
	select * from stat482; /* Print the new table */
quit;

proc sql;
create table stat475 as
select id, hw1, hw2, exam,((hw1 + hw2) * 0.25 + exam)/(25 * 2 + 100) * 100 as total
	from stat475;
	select * from stat475;
quit;

proc sql;
select a.id, a.total
	from stat482 as a
	having a.total = max(a.total) /*Select id with highest value */
union
select b.id, b.total
	from stat475 as b
	having b.total = max(b.total);
quit;


/* (c) Combine all proc sql's in part (b) into one
proc sql statement */

proc sql;
select a.id, ((a.hw1 + a.hw2 + a.hw3) * 0.6 + exam1)/(60 * 3 + 100) * 100 as total
	from stat482 as a
	having total = max(total)
union
select b.id, ((b.hw1 + b.hw2) * 0.25 + b.exam)/(25 * 2 + 100) * 100 as total
	from stat475 as b
	having total = max(total);
quit;

