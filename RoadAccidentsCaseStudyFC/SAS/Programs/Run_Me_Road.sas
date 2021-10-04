*********************************************************************
*																  	*
*  Name: Run_Me_Road.sas										  	*
*  Description: Run this to run all sections of the Road			*
*				accidents case study.								*
*																	*
*  Creation Date: 2021-09-30										*
*																	*
*********************************************************************
;

*MAKE SURE THAT YOU HAVE RUN AUTOEXEC.SAS BEFORE ATTEMPTING TO RUN THIS CODE;



*DO NOT EDIT;

%inc "&sas_root.\Programs\Accident_Import.sas" ; *run data import code;
%inc "&sas_root.\Programs\Accident_Model.sas" ; *run code to find correlations and create regression model;
%inc "&sas_root.\Programs\Graph_Report.sas" ; *run cide to generate reports;


