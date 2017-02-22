## Getting data
library(data.table)
library(ggplot2)

## Create new directory for png files 
if(dir.exists("./CourseProject2/")) getwd() else dir.create("./CourseProject2")
setwd("./CourseProject2/")

## Download data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "data.zip")
unzip(zipfile = "data.zip", overwrite = TRUE)

##Read data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## subset of data for Baltimore, fips == "24510"
baltData <- subset(NEI, fips=="24510")
data<-subset(baltData, type==c("POINT","NONPOINT", "ON-ROAD" , "NON-ROAD"))

#aggregate total pollution by year and type
totyear <- aggregate(Emissions~year+type, data=data, FUN=sum)

#Column Names
names(totyear)<-c("Year", "Type", "PM25_Emission")

##Draw a chart with points and lines
png("plot3.png", width=640, height=480)
ggplot(data = totyear, aes(x=Year, y=PM25_Emission, group=Type, color=Type))+geom_line()+geom_point()
dev.off()

