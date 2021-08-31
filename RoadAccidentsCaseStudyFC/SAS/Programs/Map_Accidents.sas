*********************************************************************
*																  	*
*  Name: Map_Accidents.sas								  			*
*  Description: using proc gmap to create maps of road accidents.	*
*																	*
*  Creation Date: 2021-08-26										*
*																	*
*********************************************************************
;

*get accident data used in graph and combine with uk map;

*DOESNT CURRENTLY WORK;




/*
pattern v=e; *set pattern as empty for now;
title 'UK Map Showing';
* use a SAS-supplied map data set (US) as both the map and response data sets;
proc gmap
map=maps.uk
data=maps.uk (obs=1)
all;
id id;
choro id / nolegend;
run;
quit;
*/
data long_lat(rename=(longitude=long latitude=lat) keep=Longitude latitude accident_severity); set raw.accidents ;
run;


data my_map; set maps.uk ;
run;
data combined; set my_map long_lat ;
run;

data my_map locations; set combined;
if anno_flag=1 then output locations;
else output my_map;
run;


proc gmap data=my_map map=my_map anno=anno_locations;
id id;
choro id / levels=1 nolegend
coutline=gray99;
run;