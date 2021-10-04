# Investigating Road Accident Data
Using 2016 UK Government Data to investigate road accident variables with SAS and R.

Note: Any ignore.txt files are only there so that file structure is maintained.

## Road Accidents Data Analysis: Report
The 2016 datasets for road traffic accidents, casualties and vehicles used in this case study are from government data. They contain many variables giving detail about each accident, vehicle and casualty, indexed by an Accident Index reference number. Variables include the age and sex of drivers and casualties, speed limit of the road, location (by Longitude and Latitude) and the police force that attended. The purpose of this case study is to analyse the given data and investigate possible relationships between variables.

Using R it was possible to import the data and plot each accident on a map of Great Britain, coloured by the severity of the accident (Fatal, Serious or Slight). From the graph in Figure 1, we can see that most accidents are only slight accidents, and that accidents tend to occur more frequently in areas with more roads and a greater population density, as you would expect (around Greater London and Birmingham have far more accidents than in the Scottish Highlands, for example).

![acc_map2](https://github.com/felix7c/Road-Accidents-Case-Study/blob/main/RoadAccidentsCaseStudyFC/R/acc_map2.jpeg)
#### Figure 1: A map showing the road accidents in Great Britain in 2016, coloured by the accident severity.


We can see one possible error on this map: off the West coast of Cornwall, there seems to be a serious road accident in the sea – this observation could have had its Longitude/Latitude incorrectly entered in this dataset.

After this, we imported the accidents, casualties and vehicles datasets into SAS and joined them on their Accident Index, applying formats to selected variables that may be used in analysis. We then created a correlation matrix of each numeric variable in the dataset, to see if we could pick out any correlations between variables. Obviously, some correlations would be expected, such as between Longitude and the OSGR Location Easting, as these both measure how easternly a location is. Notable correlations (with a correlation coefficient of over 0.6) include the relationship between the speed limit and whether a location is urban or rural (0.670) and the relationship between the junction detail and the 2nd road class (0.722).

Using PROC GLMSELECT, we created a regression model with casualty severity (slight, serious or fatal) as the response variable, using relevant explanatory variables from the dataset (variables that were not relevant or were highly correlated with other potential explanatory variables were removed).
For our model, the casualty type (e.g pedestrian, cyclist, car passenger) is the variable that reduces errors most when trying to predict the casualty severity outcome. The next most important is whereabouts the vehicle left the carriageway, followed by the speed limit and then the age of the casualty. (See Fig. 2).
In total, 22 variables were used in the regression model for casualty severity: Casualty Type, where the vehicle left the carriageway, speed limit, Age of Casualty, First Point of Impact, Police Force, Whether a police officer attended, Light Conditions, Hit Object off Carriageway, Sex of Driver, Vehicle Manoeuvre, Junction Location, Number of Casualties, Vehicle Type Age of Vehicle, First Road Class, Pedestrian Location, Casualty Class, Urban or Rural Area, whether the pedestrian was a road worker, Road Surface Condition, and Age of Driver. The SAS code will generate a PDF explaining the model in more detail.


![image](https://user-images.githubusercontent.com/88533856/135860801-fef9afaa-199f-4b79-ab86-74a41645615e.png)
#### Figure 2: Progression of errors for casualty severity.

We then used SAS to investigate the distribution of casualty age for each type of casualty severity (slight, serious or fatal), as well as investigate other variables in more detail (run the code to generate full output report PDF).

![image](https://user-images.githubusercontent.com/88533856/132186170-234de3c2-1c92-4a00-8083-2f0f378baec5.png)
#### Figure 3: Boxplots of casualty age by casualty severity.

![image](https://user-images.githubusercontent.com/88533856/132186265-e7c094c9-12e8-41c0-8c5a-35ae8f9a83e2.png)
#### Figure 4: Density plot of casualty age by casualty severity.

Although the three casualty severities have very similar age distributions, fatal injuries seem to occur to slightly older people than slight or serious injuries. This could suggest that older people are more likely to die from road accidents. Looking at the distributions of casualty ages, the interquartile range spans from early twenties to approximately the age of fifty for slight and serious accidents, and from mid twenties to early sixties for fatal accidents. However, for each casualty type the range covers all ages.

Next, we created a stacked bar chart showing the frequency count of each vehicle involved in a road accident, stacked by severity of casualty hit by that vehicle. Unsurprising, cars were by far the most common type of vehicle involved in a road accident, followed by bicycles and motorbikes under 125cc.
The plot in Fig. 5 also shows that the vast majority of accidents only lead to slight injuries for each casualty.

![image](https://user-images.githubusercontent.com/88533856/132186320-806d245e-7358-4419-99d1-fdf26c23f96a.png)
#### Figure 5: A bar chart showing the frequency count of each vehicle involved in a road accident, stacked by severity of casualty hit by that vehicle.

Looking at the weather conditions in Fig. 6, we see that the majority of accidents occur in fine weather with no high winds, followed by rainy weather with no high winds. This is to be expected as these weather conditions are far more common than snow, high winds or other conditions (even though these conditions may lead to more accidents or more severe accidents).

![image](https://user-images.githubusercontent.com/88533856/135861628-52c8bac5-33c0-43f1-a0e1-04006ff5f0bc.png)
#### Figure 6: A bar chart showing the frequency count of each weather condition, stacked by severity of casualty.

Fig. 7 shows that the vast majority of casualty types are car passengers, followed by pedestrians and then cyclists.

![image](https://user-images.githubusercontent.com/88533856/135863971-c9c97fbb-2bee-4696-be64-7929a2c59616.png)
#### Figure 7: A bar chart showing the frequency count of each casualty type, stacked by severity of casualty.

Fig. 8 shows that almost all of the vehicles did not leave the carriageway.

![image](https://user-images.githubusercontent.com/88533856/135865062-90e8253d-3504-4af1-be39-545e56159da6.png)
#### Figure 8: A bar chart showing the frequency count of each location where a vehicle left the carriageway, stacked by severity of casualty.


We then looked at what time accidents tended to occur by creating a histogram showing the percent of accidents occurring in each 20-min period throughout the day, as seen in Fig. 9. Accidents occur most frequently around the ‘rush hour’ times of 9am and 5pm, as seen by the two peaks surrounding these times. Accidents occur at the lowest rate in the early hours of the day (there are far less cars on the road at this time).

![image](https://user-images.githubusercontent.com/88533856/132186409-b4ab6772-e8b0-49c7-88eb-f0a623eb6e3f.png)
#### Figure 9: A density plot of the number of accidents occurring at each 20-min time interval throughout the day.
