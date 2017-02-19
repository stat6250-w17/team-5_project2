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


title1
"Research Question 1. Which countries performed the best among top 100 Universities?"
;
title2
"Rationale: With this we can predict if the countrys education system impact the rankings or it is just college based and has no link with the country."
;
footnote1
"Observation 1: "
;
footnote2
"Observation 2: "
/*
Methodology: 
*/


run;
title;
footnote;



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
Methodology: 
*/


run;
title;
footnote;



title1
"Research Question 3. Does the % of publications done by the students in a University correlates with the Alumni Employment %?"
;
title2
"Rationale: The presence of Emergency services can make a huge difference in the death rates. Hospitals who do not provide emergency services to the patients who come there n a critical condition, can be the reason of higher mortality rates."
;
footnote1
"Observation 1 :  "
;
footnote2
"Observation 2 : "
;
/*
Methodology: 
*/


run;
title;
footnote;
