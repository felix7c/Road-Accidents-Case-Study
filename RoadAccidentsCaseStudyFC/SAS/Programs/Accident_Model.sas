*********************************************************************
*																  	*
*  Name: Accident_Model.sas										  	*
*  Description: creating regression models from the road accident	*
*	data.															*
*																	*
*  Creation Date: 2021-09-29										*
*																	*
*********************************************************************
;


*send logs to a text file rather than SAS log;
proc printto log="&sas_root.\Logs\Model_Log.txt";
run;

*carry out exploratory analysis by looking at correlations between numeric variables;
proc corr data=staging.joined out=marts.correlation noprint;
    var _numeric_;
run;





*REGRESSION MODEL FOR CASUALTY SEVERITY - SLIGHT/SERIOUS/FATAL;
*use joined dataset so have details of each casualty and other variables;

*to get list of variables for copy and paste;
*proc contents data=marts.correlation short;
*run;

*split data into test, training and validation sets;
data join_train join_test join_valid;
  set staging.joined (keep= Age_of_Casualty Age_of_Driver Age_of_Vehicle Bus_or_Coach_Passenger Car_Passenger Carriageway_Hazards Casualty_Class
       Casualty_Home_Area_Type Casualty_IMD_Decile Casualty_Reference Casualty_Severity Casualty_Type Date Day_of_Week
       Did_Police_Officer_Attend Driver_Home_Area_Type Driver_IMD_Decile Engine_Capacity_CC First_Point_of_Impact 
       Hit_Object_in_Carriageway Hit_Object_off_Carriageway Journey_Purpose_of_Driver Junction_Control Junction_Detail 
       Junction_Location Latitude Light_Conditions Local_Authority_District  
       Longitude Number_of_Casualties Number_of_Vehicles Pedestrian_Crossing_Human Pedestrian_Crossing_Physical Pedestrian_Location 
       Pedestrian_Movement Pedestrian_Road_Mn_Worker Police_Force Propulsion_Code Road_Surface_Conditions Road_Type Sex_of_Casualty 
       Sex_of_Driver Skidding_and_Overturning Special_Conditions_at_Site Speed_limit Time Towing_and_Articulation Urban_or_Rural_Area 
       Vehicle_IMD_Decile Vehicle_Leaving_Carriageway Vehicle_Location_Restricted_Lane Vehicle_Manoeuvre  
       Vehicle_Type Was_Vehicle_Left_Hand_Drive Weather_Conditions first_Road_Class snd_Road_Class ) ;

  call streaminit(1234); *set seed;
  rand=rand('uniform');

  if rand < 0.8 then output join_train;
  else if rand < 0.9 then output join_valid;
  else output join_test;
run;


*may need to impute/remove missings??;

*find out most important variables;


*saving to pdf;
ods pdf file="&sas_root.\Report\Casualty_Severity_Model_Report.pdf"  ; *location to save as pdf;
title "Regression Model of Casualty Severity Against Explanatory Variables";


*turn ods graphics on for proc glmselect plots;
ods graphics on;

*create GLM;
proc glmselect data=join_train valdata=join_valid plots=all;
  class Bus_or_Coach_Passenger Car_Passenger Carriageway_Hazards Casualty_Class
       Casualty_Home_Area_Type Casualty_IMD_Decile Casualty_Reference Casualty_Severity Casualty_Type Day_of_Week
       Did_Police_Officer_Attend Driver_Home_Area_Type Driver_IMD_Decile  First_Point_of_Impact 
       Hit_Object_in_Carriageway Hit_Object_off_Carriageway Journey_Purpose_of_Driver Junction_Control Junction_Detail 
       Junction_Location Light_Conditions Local_Authority_District  
       Pedestrian_Crossing_Human Pedestrian_Crossing_Physical Pedestrian_Location 
       Pedestrian_Movement Pedestrian_Road_Mn_Worker Police_Force Propulsion_Code Road_Surface_Conditions Road_Type Sex_of_Casualty 
       Sex_of_Driver Skidding_and_Overturning Special_Conditions_at_Site Speed_limit Time Towing_and_Articulation Urban_or_Rural_Area 
       Vehicle_IMD_Decile Vehicle_Leaving_Carriageway Vehicle_Location_Restricted_Lane Vehicle_Manoeuvre  
       Vehicle_Type Was_Vehicle_Left_Hand_Drive Weather_Conditions first_Road_Class snd_Road_Class  ; *categorical variables;
  model casualty_severity = Age_of_Casualty Age_of_Driver Age_of_Vehicle Bus_or_Coach_Passenger Car_Passenger Carriageway_Hazards Casualty_Class
       Casualty_Home_Area_Type Casualty_IMD_Decile Casualty_Reference Casualty_Type Date Day_of_Week
       Did_Police_Officer_Attend Driver_Home_Area_Type Driver_IMD_Decile Engine_Capacity_CC First_Point_of_Impact 
       Hit_Object_in_Carriageway Hit_Object_off_Carriageway Journey_Purpose_of_Driver Junction_Control Junction_Detail 
       Junction_Location Latitude Light_Conditions Local_Authority_District  
       Longitude Number_of_Casualties Number_of_Vehicles Pedestrian_Crossing_Human Pedestrian_Crossing_Physical Pedestrian_Location 
       Pedestrian_Movement Pedestrian_Road_Mn_Worker Police_Force Propulsion_Code Road_Surface_Conditions Road_Type Sex_of_Casualty 
       Sex_of_Driver Skidding_and_Overturning Special_Conditions_at_Site Speed_limit Time Towing_and_Articulation Urban_or_Rural_Area 
       Vehicle_IMD_Decile Vehicle_Leaving_Carriageway Vehicle_Location_Restricted_Lane Vehicle_Manoeuvre  
       Vehicle_Type Was_Vehicle_Left_Hand_Drive Weather_Conditions first_Road_Class snd_Road_Class ;
run;




ods pdf close;


*resets so logs sent to log from now on;
proc printto;
run;