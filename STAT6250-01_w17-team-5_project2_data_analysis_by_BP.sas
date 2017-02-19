*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;
*
This file uses the following analytic dataset to address several research
questions regarding World Ranking University.

Dataset Name: world_rank_analytic_file created in external file
STAT6250-01_w17-team-5_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

%let dataPrepFileName = STAT6250-01_w17-team-5_project2_data_preparation.sas;
%let sasUEFilePrefix = world_rank_file;

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

************************BP Research Questions ***********************************

title1
"Research Question:Which University scored highest ranking in Europe, North America, and Asia?"
;

title2
"Rationale: Show top 10 university names associated among three continents."
;
title;

title1
"Research Question: Which University had the highest publication and is there any correlation between the University Rank?"
;
title2
"Rationale: Reveal from data, if an university does more research and publishes then they rank highest."
;
footnote1
"Observation 1: "
;

*/
Methodology: 
;

title;
footnote;

title1
"Research Question: How many students are International student in Europe, North America, and Asia?"
;

title2
"Rationale:Show how many students get education outside their native country.  "
;

title;
