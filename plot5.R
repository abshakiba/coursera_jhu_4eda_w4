library(plyr)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

png('plot5.png')

veh_index <- grepl("vehicle", tolower(scc$SCC.Level.Two))
scc_veh <- scc[veh_index,]$SCC

sub_veh<- nei[ nei$SCC %in% scc_veh,]
sub_veh<- sub_veh[sub_veh$fips == "24510",]

trend <- with(sub_veh, tapply(Emissions, year, sum, na.rm=T))
trend <- as.data.frame(trend)
names(trend) = c("Emissions")
  
ggplot(trend,aes(row.names(trend), trend$Emissions))+
  geom_bar(stat = "identity")

dev.off()
