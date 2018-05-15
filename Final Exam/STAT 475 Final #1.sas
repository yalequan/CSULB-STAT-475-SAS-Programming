%let studentname = Yale Quan;

/* 1. How many lines does the file contain? */
proc sql;
title1 "This table shows how many lines the dataset contains";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
select count (stationid) as nlines  
from tmp1.snowstationsdata;
quit; 

/* 2. What are the variable names in the imported file? (Hint: use proc contents).*/

proc contents varnum data = tmp1.snowstationsdata;
title1 "This output shows the variable names in the dataset";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
run;

/* 3. How many different snow stations are the data given for? */

proc sql;
title1 "This table shows how many distinct snowstations the data represents";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
select count (distinct stationid) as nstations
from tmp1.snowstationsdata;
quit;

/*4. How many years have been the data recorded for each station?*/

proc sql number;
title1 "This table shows how many years of data each snowstation has";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
select stationid, count (year) as nyears
from tmp1.snowstationsdata
group by stationid;
quit;

/* 5. Make an ordered list of years and give the number of stations that had measurements that year*/

proc sql number;
title1 "This table shows how many distinct snowstations had measurements each year";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
select year, count (stationid) as nstations
from tmp1.snowstationsdata
group by year;
quit;

/* 6. Compute the highest value of max_SWE for each station. 
(Note: max_SWE=maximum annual Snow Water Equivalent). Order by station name */

proc sql number;
title1 "This table shows the highest Maximum Annual Snow Water Equivalent for each station";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
select stationid, max(MaxSWEinches) as largest_max_swe
from tmp1.snowstationsdata 
group by stationid;
quit;

/*7. You might have noticed by now that a station name ‘ADIN MOUNTAIN’ had been misspelled as ‘ADIN MOUTAIN’. Fix this typo. */

proc sql;
title1 "This statement renames station 'Adin Moutain' to 'Adin Mountain'";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
create table corrected_data as
select *
from tmp1.snowstationsdata;
update corrected_data
set stationname = 'ADIN MOUNTAIN'
where stationname ='ADIN MOUTAIN';
select distinct stationname
from corrected_data;
quit;

/* 8. How many different regions are involved in snow data collection? */

proc sql;
title1 "This table shows how many distinct regions the data represents";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
select count (distinct region) as nregions
from corrected_data;
quit;

/* 9. How many stations are there in each region? */

proc sql;
title1 "This table shows how many distinct snowstations are in each region";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
select region, count (stationname) as nstations
from corrected_data
group by region;
quit;

/* 10. Create a data set that contains variables STATION_ID, STATION_NAME, TOTAL_MAX_SWE, REGION, ELEVATION, LATITUDE, 
and LONGITUDE, and which entries are the snow stations that had been in operation for the most recent 50 years 
(from 1963 to 2012). That is, you have to take the stations that have records from 1963 to 2012, and compute the highest 
max_SWE values (call them TOTAL_MAX_SWE) over the duration of these 50 years. */

proc sql number;
title1 "This table shows all stations that have been in operation from 1963 to 2012";
title2 "Completed by &studentname on &SYSDATE at &SYSTIME";
create table fifty_years as
select distinct stationid, stationname, max(maxsweinches) as MaxSWE, REGION, ELEVATIONINFEET, LATITUDE, LONGITUDE
from corrected_data
where YEARRECORDBEGAN > 1962 and YEARRECORDENDS < 2013;
select *
from fifty_years;
quit;
