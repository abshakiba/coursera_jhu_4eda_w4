library(plyr)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

png('plot3.png')

mask_baltimore <- nei$fips == "24510"
sub_baltimore <- nei[mask_baltimore,]

ggplot(sub_baltimore,aes(year,Emissions, fill=type))+
  geom_bar(stat = "identity")+
  facet_grid(.~type,scales = "free",space="free")

dev.off()
