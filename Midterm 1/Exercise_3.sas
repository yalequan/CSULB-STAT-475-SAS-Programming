
data fibonacci (drop = a b);
	a = 0; 
	b = 1;
	c = 1;
		do while (c < 1000);
			output;
			c = a + b;
			a = b;
			b = c;
		end;
	run;

title1 'Fibonacci Sequence';
title2 'Observations below 1,000';
footnote1 'Yale Quan';
footnote2 '006693828';

proc print label;
label c = 'Fibonacci Number';
run;
			
