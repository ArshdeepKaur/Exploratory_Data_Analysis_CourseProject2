library(plyr)
library(ggplot2)

if (is.null(NEI) )
  {NEI <- readRDS("./coursera_4/course_proj_2/data/summarySCC_PM25.rds")}
if (is.null(SCC))
  {SCC <- readRDS("./coursera_4/course_proj_2/data/Source_Classification_Code.rds")}

aggregate.data <- with(NEI, aggregate(Emissions, by = list(year), sum))

png(file  = "./coursera_4/course_proj_2/plot1.png")
plot(aggregate.data, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions in the United States")
#polygon(aggregate.data, col = "green", border = "blue")
dev.off()