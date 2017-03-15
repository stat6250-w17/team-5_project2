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
*						Research Question #1
******************************************************************************
;
title1
"Research Question 1:Which University's scored highest ranking incompare to organizational population? Is there any correlation between highest total_score of Univesity and student to staff ratio?"
;
title2
"Rationale: This will help investigate and determine the most contributing factor for the university ranking scheme."
;
title3 "Is there any correlation between University's highest total_score and student to staff ratio?"
;
footnote1
"Observation1: Correlation plots reveal there are no strong correlations between highest total_score and student to staff ratio."
;
footnote2
"Observation2: Correlation plot indicates 25% correlation between Total_score and student to staff ratio. Linear Regression plots shows not a strong coefficient of determination value(6.50%)."
;
*/
Methodology: Initially, proc print was used to evaluate overall raw data. 
Later once most contributing variables were determined. Data plotting techniques 
such as correlation and linear regression plots were used to anser this question.
*/
;
proc corr data=TimeData_analytic nomiss 
  plots=scatter;
  var total_score student_staff_ratio ;
run;
title;
footnote;
*******************************************************************************
*					Research Question #2
*******************************************************************************
;
title1
"Research Question 2: Does highest total_score unniversity exhibits also largest publication?"
;
title2
"Rationale: Perform exploratory analysis to reveal from data, if an university does more research and publishes then they rank highest."
;
footnote1
"Observation1: Yes, various plots indicated that there is a very strong correlation between total_score and Award, hici and Award, and award and Alumini, respectively."
;
footnote2
"Observation2: Correlation plot indicates 83.20% correlation between Total_score and student being awarded highest honorary awards. Linear Regression plots shows a strong coefficient of determination value (69.20%)."
;
*/
Methodology: Initially, proc print was used to evalauate overall raw data. 
Later once most contributing variables were determined. Data plotting techniques 
such as correlation and linear regression plots were used used to answer this question.
*/
; 
proc corr data=Shanghai_analytic nomiss
	plots=scatter(alpha=.05 .01);
 	var total_score award ;
run;


title;
footnote;
*******************************************************************************
*					Research Question # 3
*******************************************************************************
;
title1
"Research Question 3: What impacts the most in the University Ranking scheme? Which variable is the best predictor for the highest Univesity Rank(i.e hici,award,or alumni)?"
;
title2
"Rationale: Determine the most contributing factor for the university ranking scheme."
;
footnote1
"Observation 1: Analysis shows that the strongest predictor of universities highest ranking was based on the number of highly cited researchers."
;
footnote2
"Observation2: Correlation plot indicates 87.10% correlation between Total_score and hici, 83.2% between Total_score and awards, 76.92 between total_score and alumni. Linear Regression plots shows 69.20% adjusted RSquare (indicates linearly fitted)."
;
footnote3
"Observation3: Correlation plot indicates 62% correlation between Total_score and publication. Linear Regression indicates 39.3% adjusted Rsquare."
;
*/
Methodology: Initially, proc print was used to evalauate overall raw data. 
Later once most contributing variables were determined. Data plotting techniques 
such as correlation,linear regression, and sgsscatter plots were used to answer this question.
*/
;
proc sgscatter data=Shanghai_analytic;
     matrix award publications hici alumni total_score/diagonal = (histogram); 
run;

proc corr data=Shanghai_analytic nomiss 
  plots=scatter(alpha=.05 .01);
  var total_score award hici alumni publications;
run;

proc sgscatter data=Shanghai_analytic;
     compare x=total_score y=(publications hici alumni award);  
run;
title;
footnote;
