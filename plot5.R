library(plyr)
library(ggplot2)

if (is.null(NEI) )
{NEI <- readRDS("./coursera_4/course_proj_2/data/summarySCC_PM25.rds")}
if (is.null(SCC))
{SCC <- readRDS("./coursera_4/course_proj_2/data/Source_Classification_Code.rds")}

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)
NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]

NEI.motor.24510 <- NEI.motor[which(NEI.motor$fips == "24510"), ]

aggregate.motor.24510 <- with(NEI.motor.24510, aggregate(Emissions, by = list(year), 
                                                         sum))
png(file  = "./coursera_4/course_proj_2/plot5.png")
plot(aggregate.motor.24510, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions from Motor Vehicle Sources")
dev.off()

