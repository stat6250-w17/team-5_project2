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

************************MF Research Questions ***********************************
title1
"Research Question 1: Analyze which are top 5 countries have highest total_score universities every year?"
;

title2
"Rationale: This analysis will help identify the superpower country for higher education. This analysis will also help understand the factors that help achieve the top spot."
;

footnote1
"Observation 1:"
;
footnote1
"Observation 2:"
;
/*
Methodology: 
*/

run;
title;
footnote;



title1
"Research Question: Which universities have a consistent ranking over the years?"
;
title2
"Rationale: This analysis will help understand which universities are consistent in maintaining their education system and provide a better education. This analysis will also help identify the goals of the universities."
;

footnote1
"Observation 1:"
;
footnote1
"Observation 2:"
;
/*
Methodology: 
*/

run;
title;
footnote;


title1
"Research Question: Analyze top ranking universities in attributes of teaching, research, citations, international, income?"
;

title2
"Rationale:This analysis will help to understand performance of universities across five main indicators underling the teaching, research, citations, international overlook and income."
;

footnote1
"Observation 1:"
;
footnote1
"Observation 2:"
;
/*
Methodology: 
*/
run;
title;
footnote;
