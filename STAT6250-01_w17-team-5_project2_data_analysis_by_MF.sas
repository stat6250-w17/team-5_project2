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
		X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget
    (SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";			
		%include ".\&dataPrepFileName.";
	%end;
%else
	%do;
		%include "~/&sasUEFilePrefix./&dataPrepFileName.";
	%end;
%mend;
%setup;

************************MF Research Questions ***********************************;

title1
"Research Question 1: Analyze which are top 5 countries have highest total_score universities every year?"
;

title2
"Rationale: This analysis will help identify the superpower country for higher education. This analysis will also help understand the factors that help achieve the top spot."
;

footnote1
"Observation 1: The output shows the universities and country with the highest total score for the year 2016"
;
footnote2
"Observation 2: The world rank for the respective universities is also displayed, so we can corelate the world ranking with the total score."
;
/*
Methodology: 
 Use proc sort to sort the dataset by the total_score in descending order to get the highest score universities.
 Use proc print to print to print display the variables year, world_rank, country, university name, total_score.
 Use where statement to display the data for year 2016.
 Use class statement to categorize data for years.
*/

proc print data=CWUR_Times_analytic_sorted;
  var year world_rank country university_name total_score;
  where year=2016;
run;

title;
footnote;

title1
"Research Question 2: Which universities have a consistent ranking over the years?"
;
title2
"Rationale: This analysis will help understand which universities are consistent in maintaining their education system and provide a better education. This analysis will also help identify the goals of the universities."
;

footnote1
"Observation 1: The results display the world rank for the universities with respect to the parrticular year"
;
footnote2
"Observation 2: The results show that the California Institute of Technology has world rank =1 consistenly for year 2012 to 2016. Harvard university has world rank =2 consistently for year 2012 2014 2015.. "
;
/*
Methodology: 
 Use proc means to determine the world rank of all the variables
 Use proc print to print to print display the variables year, world_rank, university name.
 Use class statement to categorize data for and world_rank year.
*/
proc means data=CWUR_Times_analytic_file;
  var world_rank university_name year;
  class world_rank year;
run;

proc print data=CWUR_Times_analytic_file;
  var world_rank university_name year;
run;


*proc sort data=CWUR_Times_analytic_file out=CWUR_Times_worldrank_sorted;
* by world_rank; 
*run;
*proc print data=CWUR_Times_worldrank_sorted;
*var world_rank university_name year;
*run;


title;
footnote;


title1
"Research Question 3: Analyze top ranking universities in attributes of teaching, research, citations, international, income?"
;

title2
"Rationale:This analysis will help to understand performance of universities across five main indicators underling the teaching, research, citations, international overlook and income."
;

footnote1
"Observation 1: The results display the mean, std. deviation, minimum, maximum values for the attributes that are used as variables teaching, research, citations, international, income "
;
footnote2
"Observation 2: It can be inferred form the results that the highest rranking university California Institute of Technology has highest mean, lowest std deviation for its attributes. Also the minimum and maximum values for the attributes can be compared with other universities to anlayze the quality of education."
;
/*
Methodology: 
  use proc summary to create summarized output of the statistics - mean, std. deviation, min, max
  use output to create a new dataset with for the performance indicators
  use mean statement fot the statistics
*/
proc summary data=CWUR_Times_analytic_file print;
  var quality_of_faculty research citations international income;
  class university_name;
  output out=CWUR_Times_performance
  mean=Avgquality_of_faculty Avgresearch Avgcitations Avginternational Avgincome;
run;

title;
footnote;
