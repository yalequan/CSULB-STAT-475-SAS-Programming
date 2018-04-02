data knee;
	input ID $ knee $ visit_1 visit_2 vist_3 visit_4;
	cards;

	01 1 0  5  7 10
	02 1 0 10 15 15
	02 2 3  5  8 10
	03 1 0  3  3  3
	03 2 0  6  9  9
	04 1 0  4 10 10
	;

data knee_1;
set knee;
	if knee = '2' then delete;
run;

data knee_2;
set knee;
	if knee = '1' then delete;
	run;

data k1;
	set knee_1;
	array k{4} _numeric_;
	do visit =  1 to 4;
		score = k{visit};
		output;
	end;

	keep ID visit score;
	run;
title;
title1  'Patient Satisfaction';
title2  'Knee 1';
options nonumber nodate;
proc print noobs data = k1;
run;

data k2;
	set knee_2;
	array k{4} _numeric_;
	do visit = 1 to 4;
	   score = k{visit};
	   output;
	end;

	keep ID visit score;
	run;
title;
title1 'Patient Satisfaction';
title2 'Knee 2';
options nonumber nodate;
proc print noobs data = k2;
run;
data overall;
	merge k1(rename=(score=score_knee1)) k2(rename=(score=score_knee2));
	by ID;
	run;
proc format;
value visitfmt 1 = 'pre_op'
			   2 = 'day 1'
			   3 = 'week 1'
			   4 = 'month 1'
			   ;
run;
title;
title1 'Patient Satisfaction';
title2 'Overall Scores';
options nonumber nodate;
proc print noobs data = overall;
	format visit visitfmt.;
run;
