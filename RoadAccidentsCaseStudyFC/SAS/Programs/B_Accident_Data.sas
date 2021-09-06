*********************************************************************
*																  	*
*  Name: B_Accident_Data.sas									  	*
*  Description: manipulating and analysing data from the road 		*
*				accidents case study to plot.						*
*																	*
*  Creation Date: 2021-08-27										*
*																	*
*********************************************************************
;


*carry out exploratory analysis by looking at correlations between numeric variables;
proc corr data=staging.joined out=marts.correlation noprint;
    var _numeric_;
run;





*create dataset without missing variables for graphs, and set variable labels;
data work.joined_no_miss ;
  set staging.joined (keep= age_of_casualty casualty_Severity vehicle_Type Weather_Conditions time);
  if missing(age_of_casualty)=0 and  missing(casualty_Severity)=0 ; *makes sure only non missing are kept;
  label Age_of_Casualty='Age of Casualty' Casualty_Severity='Casualty Severity';
run;

*plotting and saving to pdf;
ods pdf file="&sas_root.\Report\Graphs_Road_Report.pdf"  ; *location to save as pdf;

title "Boxplot of Casualty Age by Severity of Casualty";
proc sgplot data=work.joined_no_miss;
  vbox age_of_casualty / group=casualty_Severity;
  styleattrs datacolors=(blue orange red);
run;


title "Density Plot of Casualty Age by Severity of Casualty";
proc sgplot data=work.joined_no_miss;
  density age_of_casualty / group=casualty_Severity;
   styleattrs datacontrastcolors=(blue orange red);
run;


title "Bar Chart of The Amount of Vehicles Involved in Accidents per Vehicle Type, Stacked by Severity of Casualty";
proc sgplot data=work.joined_no_miss;                                                                                                       
   vbar vehicle_type / group=casualty_Severity ;
   styleattrs datacolors=(red orange blue);
run;


title "Histogram of Time of Accident";
proc sgplot data=raw.accidents;                                                                                                       
   histogram time ;
run;


ods pdf close;
title;





