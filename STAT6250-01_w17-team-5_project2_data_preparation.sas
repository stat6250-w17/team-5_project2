*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;
*
[Dataset 1 Name] World University Rankings – CWURdata

[Dataset Description] World University Rankings from the Saudi Arabia based Center for World Rankings 

[Experimental Unit Description] Top 100 Universities from all over the world 

[Number of Observations] 2200 

[Number of Features] 14 

[Data Sources] https://www.kaggle.com/mylesoneill/world-university-rankings/downloads/world-university-rankings.zip 
This dataset is available on kaggle.com. It was downloaded as a Zip file, which on extraction gives a csv file. 

[Data Dictionary] https://www.kaggle.com/mylesoneill/world-university-rankings 

[Unique ID Schema] Composite Key (world_rank + institution + year)
 
--

[Dataset 2  Name]: World University Rankings - Time-Data 

[Dataset Description]: Times Higher Education World University Ranking 

[Experimental units]: Times higher education world university rankings 

[Number of Observations]: 2603 

[Number of features]: 14 

[Data source]: https://www.kaggle.com/mylesoneill/world-university-rankings/downloads/world-university-rankings.zip 

[Data Dictionary]: https://www.kaggle.com/mylesoneill/world-university-rankings.
 
[Unique ID Schema]: The columns “world_rank”, “university_name” and “Year” together form a composite key.

--

[Dataset 3 Name]: Academic Ranking of World Universities-ShanghaiData 

[Dataset Description]: Academic Ranking of World Universities- Shanghai Ranking. 

[Experimental units Description]: Founded in China in 2003, Shanghai Ranking is well noted for equally influential ranking by the Academic Ranking of World Universities.

[Number of Observations]: 4,898 

[Number of features]: 11 

[Data source]: https://www.kaggle.com/mylesoneill/world-university-rankings/downloads/world-university-rankings.zip. This dataset was available under ShanghaiData.csv.

[Data Dictionary]: https://www.kaggle.com/mylesoneill/world-university-rankings. 

[Unique ID Schema]: Composite Key for the following IDs: World_Rank, University_Name, total_score, and year.
;

* setup environmental parameters;
%let inputDataset1URL =
https://github.com/stat6250/team-5_project2/blob/master/Data/cwur-edited.xls?raw=true
;
%let inputDataset1Type = XLS;
%let inputDataset1DSN = cwurData_raw;

%let inputDataset2URL =
https://github.com/stat6250/team-5_project2/blob/master/Data/timesData-edited.xls?raw=true
;
%let inputDataset2Type = XLS;
%let inputDataset2DSN = timesData_raw;

%let inputDataset3URL =
https://github.com/stat6250/team-5_project2/blob/master/Data/shanghaiData-edited.xls?raw=true
;
%let inputDataset3Type = XLS;
%let inputDataset3DSN = shanghaiData_raw;



* load raw datasets over the wire, if they doesn't already exist;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile TEMP;
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;
%loadDataIfNotAlreadyAvailable(
    &inputDataset1DSN.,
    &inputDataset1URL.,
    &inputDataset1Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset2DSN.,
    &inputDataset2URL.,
    &inputDataset2Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset3DSN.,
    &inputDataset3URL.,
    &inputDataset3Type.
)



* sort and check raw datasets for duplicates with respect to their unique ids,
  removing blank rows, if needed;
  
proc sort
        nodupkey
        data=cwurData_raw
        dupout=cwurData_raw_dups
        out=cwurData_raw_sorted
    ;
    by
        world_rank
        university_name
        year
    ;
run;

proc sort
        nodupkey
        data=timesData_raw
        dupout=timesData_raw_dups
        out=timesData_raw_sorted
    ;
    by
        world_rank
        university_name
        year
    ;
run;

proc sort
        nodupkey
        data=shanghaiData_raw
        dupout=shanghaiData_raw_dups
        out=shanghaiData_raw_sorted
    ;
    by
        world_rank
	university_name
	total_score
     	year
    ;
run;



*Converting world_rank variable type from numeric to character;

data cwurData_raw_sorted(rename=(world_rank_char=world_rank));
set cwurData_raw_sorted;
world_rank_char=put(world_rank, 1.);
drop world_rank;
run;

*Converting national_rank variable type from numeric to character;

data cwurData_raw_sorted(rename=(national_rank_char=national_rank));
set cwurData_raw_sorted;
national_rank_char=put(national_rank, 1.);
drop national_rank;
run;


*Combining datasets CWUR and ShanghaiData vertically;

data CWUR_Shanghai_Data;
	set cwurData_raw_sorted shanghaiData_raw_sorted;
run;

proc print data=CWUR_Shanghai_Data noobs;
run;


* build analytic dataset from vertically merged sorted datasets with the 
least number of columns and minimal cleaning/transformation needed to address 
research questions in corresponding data-analysis files;
data CWUR_Shanghai_analytic_file;
    retain
    	world_rank
		university_name
		country
		alumni
		publications
		total_score
		year      
    ;
    keep
        world_rank
		university_name
		country
		alumni
		publications
		total_score
		year
    ;
    set 
		CWUR_Shanghai_Data
	;
run;

