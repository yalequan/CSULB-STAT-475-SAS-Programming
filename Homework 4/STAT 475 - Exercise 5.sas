/*

Exercise 5.  A teacher surveyed her 5th graders in regard to what kind and how many pets their families own.  
The data in file pets.dat contain kidÅfs gender (boy/girl), name of the pet owned, and the number of pets owned. 
Use the magic of proc tabulate to reproduce the table below. Make sure to match colors and alignments. 
The pictures of the cute animals are in files cat.jpg, dog.jpg, and fish.jpg.

*/

data pets;
input gender $ pet $ npets @@;
cards;
boy dog 1 boy  fish 3 girl cat  1 girl dog 6 
boy cat 3 boy  dog  1 girl fish 2 girl cat 2 
boy dog 2 girl cat  2 boy  cat  2 girl dog 4
;
proc format;
value $petfmt
	'cat' = 'C:\Users\yaleq\Desktop\cat.jpg'
	'dog' = 'C:\Users\yaleq\Desktop\dog.jpg'
	'fish' = 'C:\Users\yaleq\Desktop\fish.jpg';

proc tabulate;
title 'Number of Cute Pets Owned by Families of 5th Graders';
class gender pet;
classlev pet/S = [background = green foreground = white postimage = $petfmt.];
classlev gender/S = [background = purple just = r foreground = white];
var npets;
table gender={S=[background = blue foreground = white]}, pet={S=[background = pink foreground = white]}*npets = ' ' *sum/box = '# of Pets';
keylabel sum = ' ';
run; 
