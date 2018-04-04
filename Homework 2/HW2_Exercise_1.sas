data asthma;
input Patient 1-2 Weight 4-6 Height 8-9 Age 11-12 BMI Smoking$ 25-36 Asthma$;
cards;
14 167 70 65 23.9593878	never	 	 no
9  .   74 64 .			never		 yes
4  165 65 25 27.4544379	occasionally no
2  152 67 60 23.8039652	heavy smoker yes
13 161 70 77 23.0985714	occasionally yes
1  143 64 55 24.5432129	occasionally no
7  148 71 61 20.6395556	occasionally yes
11 281 69 45 41.4919135	heavy smoker yes
5  220 70 58 31.5632653	occasionally no
6  182 64 26 31.2368164	never		 no
8  190 66 74 30.6634527	occasionally yes
12 .   .  39 .			occasionally yes
3  190 69 63 28.0550305	never		 no
15 148 67 53 23.1775451	never		 yes
10 152 65 61 25.2913609	never		 yes
;
ods html body = 'C:\Users\yaleq\Desktop\outdata_Exercise_1_Yale_Quan.html';
title1 'Asthma Patients';
title2 'Basic Data Set';
footnote 'Data from Medical Records';
proc sort data = asthma out = asthma_out;
	by Smoking Patient;
	run;
proc print noobs data = asthma_out;
	var Patient Asthma Age BMI;
	format BMI comma6.2;
	by Smoking;
run;
ods html close;
