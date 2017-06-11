library(plyr)
library(ggplot2)

if (is.null(NEI) )
{NEI <- readRDS("./coursera_4/course_proj_2/data/summarySCC_PM25.rds")}
if (is.null(SCC))
{SCC <- readRDS("./coursera_4/course_proj_2/data/Source_Classification_Code.rds")}

NEI.24510 <- NEI[which(NEI$fips == "24510"), ]
aggregate.24510 <- with(NEI.24510, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.24510) <- c("year", "Emissions")

png(file  = "./coursera_4/course_proj_2/plot2.png")
plot(aggregate.24510, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
 xlab = "Year", main = "Total Emissions for Baltimore County", xlim = c(1999, 2008))
dev.off()