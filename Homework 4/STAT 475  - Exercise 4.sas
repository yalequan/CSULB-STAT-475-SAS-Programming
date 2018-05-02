/* Exercise 4.  Run a macro loop to illustrate the 
Law of Large Numbers */

%macro LLN(p,n);

%let name = Yale Quan;

title1 "This assignment is completed by &name on &sysday, &sysdate, at &systime";

data Bernoulli;
	do i = 1 to &n;
		b = rand("Bernoulli", &p);
		sum + b;
		xbar = sum / i;
		output;
		keep xbar i;
	end;
	run; 

symbol interpol = join value = triangle color = red;
proc gplot;
	plot xbar * i/vref = &p;
	run;

%mend;

%LLN(0.5, 100);

