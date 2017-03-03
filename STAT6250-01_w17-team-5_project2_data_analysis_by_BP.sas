*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding World Ranking University.

Dataset Name: world_rank_file created in external file
STAT6250-01_w17-team-5_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

%let dataPrepFileName = STAT6250-01_w17-team-5_project2_data_preparation.sas;
%let sasUEFilePrefix = team-5_project2;

* load external file that generates analytic dataset world_rank_analytic_file 
using a system path dependent on the host operating system, after setting 
the relative file import path to the current directory, if using Windows;

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

******************************************************************************
*						BP Analysis begins Here
*
*						Research Question #1
******************************************************************************
;
title1
"Research Question 1:Which University's scored highest ranking incompare to organizational population? Is there any correlation between highest total_score of Univesity and student to staff ratio?"
;
title2
"Rationale: This will help investigate  scheme."
;
*/
Methodology: Initially, proc print was used to evalauate overall raw data. 
Later once most contributing variables were determined. Various data plotting techniques are used.
*/
;
proc freq data=TimeData_analytic;
	table university_name total_score;
run;

title "Is there any correlation between University's highest total_score and student to staff ratio?" ;
footnote1
"Observation1: Yes, plots show there is a very strong correlation"
;

title;
footnote;
*******************************************************************************
*					Research Question #2
*******************************************************************************
;
title1
"Research Question 2: Does highest total_score unniversity exhibits also largest publication?"
;
proc freq data=Shanghai_analytic;
	table university_name publications;
run;

footnote1
"Observation1: Yes, variable plots indicated that there is a very strong correlation between total_score and Award, hici and Award, and award and Alumini, respectively."
;

title2
"Rationale: Reveal from data, if an university does more research and publishes then they rank highest."
;


*/
Methodology: Initially, proc print was used to evalauate overall raw data. 
Later once most contributing variables were determined. Various data plotting techniques are used.
*/
 
title;
footnote;
*******************************************************************************
*					Research Question # 3
*******************************************************************************
title1
"Research Question 3: What impacts the most in the University Ranking scheme? Which variable is the best predictor for the highest Univesity Rank(i.e hici,award,or alumni)?"
;
proc freq data=Shanghai_analytic;
	table university_name award;
run;

*/
Methodology: Initially, proc print was used to evalauate overall raw data. 
Later once most contributing variables were determined. Various data plotting techniques are used.
*/
;
footnote1
"Observation 1: hici is based on the number of highly cited researchers"
;
title;
footnote;
