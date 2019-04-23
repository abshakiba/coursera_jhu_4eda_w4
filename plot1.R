library(plyr)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

png('plot1.png')

trend <- with(nei, tapply(Emissions, year, mean, na.rm=T))


barplot(trend,
        xlab = "Years",
        ylab = "Emissions")
dev.off()
