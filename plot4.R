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


## Merge NEI with SCC

data<- merge(NEI, SCC, by="SCC")
data1<-data[grep("Coal", data$Short.Name,ignore.case=TRUE),]


#aggregate total pollution by year and type
totyear <- aggregate(Emissions~year, data=data1, FUN=sum)

#Column Names
names(totyear)<-c("Year", "Emission")

##Draw a chart with points and lines
png("plot4.png", width=640, height=480)
ggplot(data = totyear, aes(x=Year, y=Emission))+geom_bar(colour="black", fill="red", stat="identity")+ggtitle('Total Emissions from coal sources from 1999 to 2008')+ylab(expression('Total PM'[2.5]*" Emissions"))
dev.off()

