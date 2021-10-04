*********************************************************************
*																  	*
*  Name: Accident_Import.sas								  	*
*  Description: importing data from the road accidents case study,	*
*				and then joining the data.							*
*																	*
*  Creation Date: 2021-08-26										*
*																	*
*********************************************************************
;


*send logs to a text file rather than SAS log;
proc printto log="&sas_root.\Logs\Import_Log.txt";
run;


*Accidents dataset (need to do it in data step for efficiency, as guessing rows would have to be too high on proc import due to 'NULL' in numeric cols);
data raw.accidents ;
  infile "&data_location.\dftRoadSafety_Accidents_2016.csv"
  delimiter = ","
  missover 
  dsd 
  firstobs=2;
  *continue reading if encounter mv / ignore delimiters enclosed in double quotes/read data from 2nd line onwards;
  
  informat
  Accident_Index $40.
  Location_Easting_OSGR 20.
  Location_Northing_OSGR  20.
  Longitude 20.6
  Latitude 20.6
  Police_Force 8. 
  Accident_Severity 15.
  Number_of_Vehicles 8.
  Number_of_Casualties 8.
  Date ANYDTDTE9.
  Day_of_Week 5.
  Time time12.3
  Local_Authority_District 20.
  Local_Authority_Highway $30.
  first_Road_Class 10.
  first_Road_Number 12.
  Road_Type 8.
  Speed_limit read_null_fmt.
  Junction_Detail 8.
  Junction_Control 8.
  snd_Road_Class 8.
  snd_Road_Number 8.
  Pedestrian_Crossing_Human 8.
  Pedestrian_Crossing_Physical 8.
  Light_Conditions 8.
  Weather_Conditions 8.
  Road_Surface_Conditions 8.
  Special_Conditions_at_Site 8.
  Carriageway_Hazards  8.
  Urban_or_Rural_Area 8.
  Did_Police_Officer_Attend 8.
  LSOA_of_Accident_Location $20.;


  format
  Accident_Index $40.
  Location_Easting_OSGR 20.
  Location_Northing_OSGR  20.
  Longitude 20.6
  Latitude 20.6
  Police_Force 8. 
  Accident_Severity 15.
  Number_of_Vehicles 8.
  Number_of_Casualties 8.
  Date DATE9.
  Day_of_Week 5.
  Time time12.3
  Local_Authority_District 20.
  Local_Authority_Highway $30.
  first_Road_Class 10.
  first_Road_Number 12.
  Road_Type 8.
  Speed_limit 8.
  Junction_Detail 8.
  Junction_Control 8.
  snd_Road_Class 8.
  snd_Road_Number 8.
  Pedestrian_Crossing_Human 8.
  Pedestrian_Crossing_Physical 8.
  Light_Conditions 8.
  Weather_Conditions 8.
  Road_Surface_Conditions 8.
  Special_Conditions_at_Site 8.
  Carriageway_Hazards  8.
  Urban_or_Rural_Area 8.
  Did_Police_Officer_Attend 8.
  LSOA_of_Accident_Location $20.;

  input
  Accident_Index $
  Location_Easting_OSGR 
  Location_Northing_OSGR  
  Longitude 
  Latitude 
  Police_Force 
  Accident_Severity 
  Number_of_Vehicles 
  Number_of_Casualties 
  Date
  Day_of_Week 
  Time 
  Local_Authority_District 
  Local_Authority_Highway $
  first_Road_Class 
  first_Road_Number 
  Road_Type 
  Speed_limit 
  Junction_Detail 
  Junction_Control 
  snd_Road_Class 
  snd_Road_Number 
  Pedestrian_Crossing_Human 
  Pedestrian_Crossing_Physical
  Light_Conditions 
  Weather_Conditions 
  Road_Surface_Conditions 
  Special_Conditions_at_Site 
  Carriageway_Hazards  
  Urban_or_Rural_Area 
  Did_Police_Officer_Attend
  LSOA_of_Accident_Location $;

  
run;


*Casualties dataset;
data raw.casualties ;
  infile "&data_location.\dftRoadSafety_Casualties_2016.csv"
  delimiter = ","
  missover 
  dsd 
  firstobs=2;
  *continue reading if encounter mv / ignore delimiters enclosed in double quotes/read data from 2nd line onwards;
  
  informat
  Accident_Index $40.
  Vehicle_Reference 8.	
  Casualty_Reference 8.
  Casualty_Class 8.	
  Sex_of_Casualty 8.	
  Age_of_Casualty 8.	
  Age_Band_of_Casualty 8.	
  Casualty_Severity 8.	
  Pedestrian_Location	 8.	
  Pedestrian_Movement 8.	
  Car_Passenger 8.	
  Bus_or_Coach_Passenger 8.	
  Pedestrian_Road_Mn_Worker 8.	
  Casualty_Type 8.	
  Casualty_Home_Area_Type 8.	
  Casualty_IMD_Decile 8.;
  
  format
  Accident_Index $40.
  Vehicle_Reference 8.	
  Casualty_Reference 8.
  Casualty_Class 8.	
  Sex_of_Casualty 8.	
  Age_of_Casualty 8.	
  Age_Band_of_Casualty 8.	
  Casualty_Severity 8.	
  Pedestrian_Location	 8.	
  Pedestrian_Movement 8.	
  Car_Passenger 8.	
  Bus_or_Coach_Passenger 8.	
  Pedestrian_Road_Mn_Worker 8.	
  Casualty_Type 8.	
  Casualty_Home_Area_Type 8.	
  Casualty_IMD_Decile 8.;

  input
  Accident_Index $
  Vehicle_Reference 	
  Casualty_Reference 
  Casualty_Class 
  Sex_of_Casualty 	
  Age_of_Casualty 	
  Age_Band_of_Casualty 	
  Casualty_Severity	
  Pedestrian_Location
  Pedestrian_Movement 
  Car_Passenger 
  Bus_or_Coach_Passenger 
  Pedestrian_Road_Mn_Worker 
  Casualty_Type
  Casualty_Home_Area_Type 	
  Casualty_IMD_Decile ;
  
run; 


*Vehicles dataset;
data raw.vehicles ;
  infile "&data_location.\dftRoadSafety_Vehicles_2016.csv"
  delimiter = ","
  missover 
  dsd 
  firstobs=2;
  *continue reading if encounter mv / ignore delimiters enclosed in double quotes/read data from 2nd line onwards;
  
  informat
  Accident_Index $40.	
  Vehicle_Reference	 8.	
  Vehicle_Type 8.	
  Towing_and_Articulation 8.	
  Vehicle_Manoeuvre 8.	
  Vehicle_Location_Restricted_Lane 8.	
  Junction_Location	 8.	
  Skidding_and_Overturning 8.	
  Hit_Object_in_Carriageway  8.	
  Vehicle_Leaving_Carriageway 8.	
  Hit_Object_off_Carriageway 8.	
  First_Point_of_Impact	 8.	
  Was_Vehicle_Left_Hand_Drive 8.	
  Journey_Purpose_of_Driver 8.	
  Sex_of_Driver	Age_of_Driver 8.	
  Age_Band_of_Driver 8.	
  Engine_Capacity_CC 8.	
  Propulsion_Code 8.	
  Age_of_Vehicle 8.	
  Driver_IMD_Decile 8.	
  Driver_Home_Area_Type 8.	
  Vehicle_IMD_Decile 8.	;

  format
  Accident_Index $40.	
  Vehicle_Reference	 8.	
  Vehicle_Type 8.	
  Towing_and_Articulation 8.	
  Vehicle_Manoeuvre 8.	
  Vehicle_Location_Restricted_Lane 8.	
  Junction_Location	 8.	
  Skidding_and_Overturning 8.	
  Hit_Object_in_Carriageway  8.	
  Vehicle_Leaving_Carriageway 8.	
  Hit_Object_off_Carriageway 8.	
  First_Point_of_Impact	 8.	
  Was_Vehicle_Left_Hand_Drive 8.	
  Journey_Purpose_of_Driver 8.	
  Sex_of_Driver	Age_of_Driver 8.	
  Age_Band_of_Driver 8.	
  Engine_Capacity_CC 8.	
  Propulsion_Code 8.	
  Age_of_Vehicle 8.	
  Driver_IMD_Decile 8.	
  Driver_Home_Area_Type 8.	
  Vehicle_IMD_Decile 8.	;

  input
  Accident_Index $
  Vehicle_Reference	 
  Vehicle_Type 
  Towing_and_Articulation 	
  Vehicle_Manoeuvre 
  Vehicle_Location_Restricted_Lane 	
  Junction_Location	 	
  Skidding_and_Overturning 	
  Hit_Object_in_Carriageway  	
  Vehicle_Leaving_Carriageway 	
  Hit_Object_off_Carriageway 	
  First_Point_of_Impact		
  Was_Vehicle_Left_Hand_Drive 	
  Journey_Purpose_of_Driver 	
  Sex_of_Driver	Age_of_Driver 	
  Age_Band_of_Driver	
  Engine_Capacity_CC	
  Propulsion_Code 	
  Age_of_Vehicle 
  Driver_IMD_Decile 
  Driver_Home_Area_Type 
  Vehicle_IMD_Decile ;

run;






*create merged dataset (use accidents as 'left' in one-to-many);
*note rename and drop to avoid warning of duplicate index cols;
proc sql noprint;
  create table work.joined1 (drop=Accident_Index1) as
  select a.*, v.*
  from raw.accidents a LEFT JOIN raw.vehicles(rename=(Accident_Index=Accident_Index1)) v
   on a.Accident_Index=v.Accident_Index1;
quit;


*create fully merged dataset with vehicles dataset too (one-to-many as each vehicle joined with its casualty(ies) );
*note rename and drop to avoid warning of duplicate index cols;
proc sql noprint;
  create table staging.joined (drop=Accident_Index1 vehicle_reference1) as
  select a.*, c.*
  from work.joined1 a  LEFT JOIN raw.casualties(rename=(Accident_Index=Accident_Index1 vehicle_reference=vehicle_reference1)) c
   on a.Accident_Index=c.Accident_Index1 and a.vehicle_reference=c.vehicle_reference1
  order by Accident_Index;
quit;


*IMPORT FORMAT DATASETS AND APPLY FORMATS ETC;

%Format_Import(weather_fmt,Weather,B11)
%Format_Import(severity_fmt,Accident Severity,B4)
%Format_Import(veh_t_fmt,Vehicle Type,B22)
%Format_Import(cas_t_fmt,Casualty Type,B22)
%Format_Import(veh_l_fmt,Veh Leaving Carriageway,B11)



*apply formats to joined dataset;
data staging.joined;
  set staging.joined;
  format Weather_Conditions weather_fmt. Accident_Severity severity_fmt. Casualty_Severity severity_fmt.  Vehicle_Type veh_t_fmt.
		 Casualty_Type cas_t_fmt. Vehicle_Leaving_Carriageway veh_l_fmt.;
  if age_of_casualty=-1 then age_of_casualty=.;
  if speed_limit=-1 then speed_limit=.;
  label Accident_Severity="Accident Severity" Weather_Conditions="Weather Conditions"
	     Casualty_Severity="Casualty Severity" Vehicle_Type="Vehicle Type" Casualty_Type="Casualty Type"
		 Vehicle_Leaving_Carriageway="Vehicle Leaving Carriageway" Age_of_Casualty="Age of Casualty" Speed_limit="Speed Limit";
run;



*resets so logs sent to log from now on;
proc printto;
run;