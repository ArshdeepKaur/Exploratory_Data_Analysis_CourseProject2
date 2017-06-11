library(plyr)
library(ggplot2)

if (is.null(NEI) )
{NEI <- readRDS("./coursera_4/course_proj_2/data/summarySCC_PM25.rds")}
if (is.null(SCC))
{SCC <- readRDS("./coursera_4/course_proj_2/data/Source_Classification_Code.rds")}

SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.identifiers <- as.character(SCC.coal$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI$SCC %in% SCC.identifiers, ]

aggregate.coal <- with(NEI.coal, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.coal) <- c("year", "Emissions")

png(file  = "./coursera_4/course_proj_2/plot4.png")

plot(aggregate.coal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", 
     xlim = c(1999, 2008))
#polygon(aggregate.coal, col = "red", border = "red")

dev.off()