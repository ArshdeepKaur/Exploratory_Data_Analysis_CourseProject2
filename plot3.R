library(plyr)
library(ggplot2)

if (is.null(NEI) )
{NEI <- readRDS("./coursera_4/course_proj_2/data/summarySCC_PM25.rds")}
if (is.null(SCC))
{SCC <- readRDS("./coursera_4/course_proj_2/data/Source_Classification_Code.rds")}

NEI.24510 <- NEI[which(NEI$fips == "24510"), ]
aggregate.24510 <- with(NEI.24510, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.24510) <- c("year", "Emissions")

NEI.24510.type <- ddply(NEI.24510, .(type, year), summarize, Emissions = sum(Emissions))
NEI.24510.type$Pollutant_Type <- NEI.24510.type$type

png(file  = "./coursera_4/course_proj_2/plot3.png")

#Sources have seen decreases in emissions from 1999-2008 for Baltimore City Which have seen 
#increases in emissions from 1999-2000

qplot(year, Emissions, data = NEI.24510.type, group = Pollutant_Type, color = Pollutant_Type, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")
dev.off()