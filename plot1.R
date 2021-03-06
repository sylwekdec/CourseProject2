## Getting data
library(data.table)

## Create new directory for png files 
if(dir.exists("./CourseProject2/")) getwd() else dir.create("./CourseProject2")
setwd("./CourseProject2/")

## Download data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "data.zip")
unzip(zipfile = "data.zip", overwrite = TRUE)

##Read data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#aggregate total pollution by year
totyear <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)

#Column Names
names(totyear)<-c("Year", "TotalPoll")

##Draw a chart with points and lines
png('plot1.png')
getOption("scipen")
opt <- options("scipen" = 10)
getOption("scipen")
plot(totyear$Year, totyear$TotalPoll, main = "Total PM2.5 Emission by Year", xlab="Year", ylab="Emission")
lines(totyear$Year, totyear$TotalPoll)
dev.off()

