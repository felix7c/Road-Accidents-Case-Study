*********************************************************************
*																  	*
*  Name: Format_Import.sas										  	*
*  Description: macro to import formats for numeric variables from 	*
*				.xlsx files for use on the road accidents data.		*
*																	*
*  Creation Date: 2021-10-01										*
*																	*
*********************************************************************
;


%macro Format_Import(fmt_name,sheet_name,end_range);
*import format;
proc import 
datafile="&data_location.\variable lookup (1).xls"
out=work.&fmt_name. 
dbms=xls 
  replace;
  sheet="&sheet_name.";
  getnames=YES; 
  datarow=2;
  range="&sheet_name.$A1:&end_range.";
run;

*creating format dataset;
data shared.&fmt_name.;
  retain fmtname "&fmt_name." type 'N'; *format name, type =numeric;
  set work.&fmt_name. (rename=(code=start));
run;

*creating the format from the dataset;
proc format library=shared cntlin=shared.&fmt_name.;
run;
%mend;