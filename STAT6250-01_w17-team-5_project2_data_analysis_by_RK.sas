*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding Worlds University Ranking trends over the years
Dataset Name: world_rank_analytic_file created in external file
STAT6250-01_w17-team-5_project2_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;

%let dataPrepFileName = STAT6250-01_w17-team-5_project2_data_preparation.sas;
%let sasUEFilePrefix = team-5_project2;

* load external file that generates analytic dataset world_rank_analytic_file
using a system path dependent on the host operating system, after setting the
relative file import path to the current directory, if using Windows;

%macro setup;
%if
	&SYSSCP. = WIN
%then
	%do;
		X 
		"cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))"""
		;			
		%include ".\&dataPrepFileName.";
	%end;
%else
	%do;
		%include "~/&sasUEFilePrefix./&dataPrepFileName.";
	%end;
%mend;
%setup;

*******************************************************************************;
************************Research Question 1************************************;
*******************************************************************************;

title1
"Research Question 1. Which countries performed the best among top 100 Universities?"
;
title2
"Rationale: With this we can predict if the countrys education system impact the rankings or it is just college based and has no link with the country."
;

footnote1
"Observation 1: From the results it is clear that almost all countries have secured a place in top 100 universities which include USA, Australia, UK, Japan, France, etc. "
;
footnote2
"Observation 2: Another observation is that USA is the highest country with the best ranking universities in top 100"

/*
Methodology: Changed the length of the world_rank variable to 3 so it can accomodate
all the rankings. Print top 100 universities of 2015 from the dataset of CWUR. 
*/


*sort the data ascending order of world rank;
/*----
proc sort data=shanghaiData_raw_sorted out=sorted_CWUR_Times;
	by world_rank;
run;
*/


* change length of world_rank from 1 to 3 characters ;

data cwurData_raw_sorted;
length world_rank $4;
set cwurData_raw_sorted;
run;

/*ERROR in log: BY variables are not properly sorted on data set WORK.CWURDATA_RAW_SORTED. */

/*
proc contents data=cwurData_raw_sorted;
run;
*/

* print records for top 100 universities ;
proc print data=cwurData_raw_sorted (obs=100);
	var world_rank university_name country year;
	where year=2015;
run;


title;
footnote;


*******************************************************************************;
************************Research Question 2************************************;
*******************************************************************************;

title1
"Research Question 2. What is the range of total score for high (1-100), medium (101-400) and low (401-1000) ranked Universities?"
;
title2
"Rationale: This would help the Universities to analyze their scores of previous years and set a goal for future in order to achieve a high ranking."
;

footnote1
"Observation 1 : "
;
footnote2
"Observation 2 : "
;

/*
Methodology: Used Proc Format to distribute the world rankings in three 
categories of high, medium and low. Then use Proc Means to calculate
minimum and maximum of total_score arranged in the bins of world_rank
and print them.
*/

*proc format to put world ranks in bins and print them;
proc format;	
	value $world_rank		
	low-100="HIGH"		
	101-400="MEDIUM"		
	401-high="LOW"	
	;
run;

* OPTIONAL: Print the above results ;
proc print 
	data=CWUR_Shanghai_analytic_file;	
	format UniversityWorldRanking $world_rank.;
run;

/* Calculate the Min and Max values for scores using formatted rankings and 
print them to analyze the range*/
proc means 
	data=CWUR_Shanghai_analytic_file min max range;	
	var total_score university_name year world_rank;	
	format UniversityWorldRanking $world_rank.;	
	output out=by_rank_score;
run;

proc print data=by_rank_score;
run;

title;
footnote;

*******************************************************************************;
************************Research Question 3************************************;
*******************************************************************************;

title1
"Research Question 3. Does the % of publications done by the students correlates with the Alumni Employment %?"
;
title2
"Rationale: This data can be useful for the students to identify to what extent being a part of a publication helps in getting a job. "
;

footnote1
"Observation 1 : From the results it can be noticed that the alumni employment rate shows an increase with the number of publications. "
;
footnote2
"Observation 2 : Going further, more analysis would be required to conclude which all factors determine alumni employment % rather than just the publications rate. "
;

/*
Methodology:Proc Freq to create cross-tab of three variables to see
correlation between them.
*/

proc summary data=CWUR_Shanghai_analytic_file print;
	var alumni publications;
	class publications;
output out=alum_pub
	mean=AvgAlumni;
run;

/*
proc freq 
	data=cwurData_raw_sorted;
	Table 
	    alumni*publications*university_name / norow nocol;
run;
*/

title;
footnote;
