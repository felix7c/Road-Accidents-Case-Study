*********************************************************************
*																  	*
*  Name: Graph_Report.sas									  	*
*  Description: manipulating and analysing data from the road 		*
*				accidents case study to plot.						*
*																	*
*  Creation Date: 2021-09-27										*
*																	*
*********************************************************************
;


*send logs to a text file rather than SAS log;
proc printto log="&sas_root.\Logs\Report_Log.txt";
run;


*create dataset without missing variables for graphs, and set variable labels;
data work.joined_no_miss ;
  set staging.joined ;*(keep= age_of_casualty casualty_Severity vehicle_Type Weather_Conditions time);
  if missing(age_of_casualty)=0 and  missing(casualty_Severity)=0 ; *makes sure only non missing are kept;
  label Age_of_Casualty='Age of Casualty' Casualty_Severity='Casualty Severity';
run;

*plotting and saving to pdf;
ods pdf file="&sas_root.\Report\Graphs_Road_Report.pdf"  ; *location to save as pdf;



*Proc freq, proc univariate etc for key variables;
title "Frequency Plot of Casualty Severity";
proc freq data=work.joined_no_miss;
  tables Casualty_Severity Casualty_Severity*(vehicle_type weather_conditions casualty_Type Vehicle_Leaving_Carriageway speed_limit);
run;

title "Casualty Age Distribution";
proc univariate data=work.joined_no_miss;
  var Age_of_Casualty;
run;



*plots;
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


title "Bar Chart of Weather Conditions, Stacked by Severity of Casualty";
proc sgplot data=work.joined_no_miss;                                                                                                       
   vbar weather_conditions / group=casualty_Severity ;
   styleattrs datacolors=(red orange blue);
run;



title "Bar Chart of Casualty Type, Stacked by Severity of Casualty";
proc sgplot data=work.joined_no_miss;                                                                                                       
   vbar casualty_Type / group=casualty_Severity ;
   styleattrs datacolors=(red orange blue);
run;


title "Bar Chart of Where Vehicle Left Carriageway, Stacked by Severity of Casualty";
proc sgplot data=work.joined_no_miss;                                                                                                       
   vbar Vehicle_Leaving_Carriageway / group=casualty_Severity ;
   styleattrs datacolors=(red orange blue);
run;



title "Histogram of Time of Accident";
proc sgplot data=raw.accidents;                                                                                                       
   histogram time ;
run;


ods pdf close;
title;


*resets so logs sent to log from now on;
proc printto;
run;




