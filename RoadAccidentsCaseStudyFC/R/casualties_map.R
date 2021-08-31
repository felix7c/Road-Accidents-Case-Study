# R file to create a map of road accidents, based on 2016 government data
# Creation Date: 2021-08-31


library(ggplot2)
library(ggmap)

#import data from csv file in folder
#CHANGE WORKING DIRECTORY IF NECESSARY
setwd('C:/Users/Felix/Documents/My SAS Files/RoadAccidentsCaseStudyFC/SAS/Data/1_Input')
accidents2016 = read.csv('dftRoadSafety_Accidents_2016.csv')

#replace accident severity with the actual severity name
accidents2016$Accident_Severity[accidents2016$Accident_Severity == "1"] <- "Fatal"
accidents2016$Accident_Severity[accidents2016$Accident_Severity == "2"] <- "Serious"
accidents2016$Accident_Severity[accidents2016$Accident_Severity == "3"] <- "Slight"


#note: use lon, lat for ggmaps etc
uk_map = get_stamenmap(bbox = c(left = -11, bottom = 49.5, right =
                                   2.3, top = 59.5), zoom = 5, maptype = "toner") 

#plotting map:
ggmap(uk_map)+
  geom_point(aes(Longitude, Latitude,color=Accident_Severity),size=0.05,data=accidents2016)+
  labs(title = "Map of Road Accidents (2016)",x="Longitude",y="Latitude", color="Accident Severity")+
  guides(color = guide_legend(override.aes = list(size=2.5)))+
  scale_color_manual(values=c("Red", "Orange", "Blue")) #custom colours for points

