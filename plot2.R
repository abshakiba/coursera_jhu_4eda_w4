library(plyr)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

png('plot2.png')

mask_baltimore <- nei$fips == "24510"
sub_baltimore <- nei[mask_baltimore,]
trend_baltimore <- with(sub_baltimore, tapply(Emissions, year, sum, na.rm = T))



barplot(trend_baltimore,
        xlab = "Years",
        ylab = "Emissions")
dev.off()
str(trend_baltimore)
