/* Use the data below to generate an output that matches the image file OutputTable.jpeg */

data exercise;
input ID $ Age ActLevel $ Sex $ Payment;
cards;
2810 61 MOD F 34.00
2804 38 HIGH F 29.00
2807 42 LOW M  27.50
2816 26 HIGH M  20.25
2833 32 MOD F 15.50
2823 29 HIGH M 23.00
;

proc format;
value $sexfmt
	'M' = 'C:\Users\yaleq\Desktop\men.png'
	'F' = 'C:\Users\yaleq\Desktop\women.png';
run;

proc tabulate;
*Row Column;
class Sex ActLevel;
classlev Sex/S=[background = Yellow just = r postimage = $sexfmt.]; *Must specify here since we're modifying a class;
var Payment;
table Sex, ActLevel={S=[background = Purple foreground = white]}*Payment*mean/box='Mean Payment';
keylabel mean = ' ';
run;
