data exercise2;
	do counter=1 to 19;
		Response='yes';
		Group='nonsurgical';
		output;
		end;
	do counter=1 to 26;
		Response='yes';
		Group='surgical';
		output;
		end;
	do counter=1 to 1260;
		Response='no';
		Group='surgical';
		output;
	end;
		do counter=1 to 802;
		Response='no';
		Group='nonsurgical';
		output;
	end;
	run;
	proc print data=exercise2;
	run;
