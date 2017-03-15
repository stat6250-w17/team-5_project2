*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;
*IL: linebreaks should be used to create paragraphs in comment blocks, as below;
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
Methodology: Changed the length of the world_rank variable to 3 so it can 
accomodate all the rankings. Print top 100 universities of 2015 from the
dataset of CWUR. 
*/;
*IL: unused code should be deleted;
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
"Observation 1 : From the output, the Universities can analyze their score position for each year and see if they fall under High, Medium or Low rankings."
;
footnote2
"Observation 2 : As an example, California Institute of Technology University's total_score over the years from 94.8 in 2012 to 95.2 in 2016. Based on these results universities can work on their scores over the years and make their ranking consistent."
;

/*
Methodology: Used Proc Format to distribute the world rankings in three 
categories of high, medium and low. Change the length of world_rank 
variable to accommodate all rankings. Then used proc print to print the
results dividing them in categories of year and ranks.
*/

* Print the results ;
proc print 
    data=CWUR_Times_analytic_file; *cwurData_raw_sorted; *CWUR_Times_analytic_file; *CWUR_Shanghai_analytic_file; 
    var world_rank university_name country total_score year;
    *where year=2015;   
    format world_rank $world_rank.;
    BY NOTSORTED world_rank year;
run;

title;
footnote;

*******************************************************************************;
************************Research Question 3************************************;
*******************************************************************************;

title1
"Research Question 3. Does the citations done by the students in a University correlates with the quality of faculty?"
;
title2
"Rationale: This data can be useful identify that quality of teaching results in more citations or not. "
;

footnote1
"Observation 1 : From the results it can be noticed that the qulaity of faculty has not much impact on the number of citations. "
;
footnote2
"Observation 2 :  We can not specify on the rating of quality of faculty that leads to higher or lower citations as the mean varies. "
;

/*
Methodology:Proc Summary to display the output and correlation of
quality of faculty and citations of Universities.
*/ 

proc summary data=CWUR_Times_analytic_file print;
    var quality_of_faculty citations ;
    class university_name;
    output out=cit_fac
    mean=AvgQuality AvgCitations;
    where country='United States of Ame';
run;

/*
proc sort data=CWUR_Times_analytic_file;
    by university_name;
run;
proc freq 
    data=CWUR_Times_analytic_file;
    Table 
        citations*quality_of_faculty / norow nocol;
    
    where country='United States of Ame' AND year=2015;
run
*/

title;
footnote;
