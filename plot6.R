## Getting data
library(data.table)
library(ggplot2)
library(dplyr)

## Create new directory for png files 
if(dir.exists("./CourseProject2/")) getwd() else dir.create("./CourseProject2")
setwd("./CourseProject2/")

## Download data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "data.zip")
unzip(zipfile = "data.zip", overwrite = TRUE)

##Read data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


##Subset for Baltimore and Los Angeles 
baltData <- subset(NEI, fips=="24510" | fips == "06037")
baltData <- mutate(baltData, City=ifelse(fips=="24510", "Baltimore","Los Angeles"))

## Merge NEI with SCC
data<- merge(baltData, SCC, by="SCC")
data1<-data[grep("Vehicles", data$EI.Sector),]


#aggregate total pollution by year and type
totyear <- aggregate(Emissions~year+City, data=data1, FUN=sum)

#Column Names
names(totyear)<-c("Year", "City", "Emission")

##Draw a chart with points and lines
png("plot6.png", width=640, height=480)
ggplot(data = totyear, aes(x=Year, y=Emission, group=City, color=City))+geom_line(size=2)+stat_smooth(method = "lm", linetype=2)+ggtitle('Total Emissions from Motor Vehicle sources from 1999 to 2008')+ylab(expression('PM'[2.5]*" Emissions"))
dev.off()




