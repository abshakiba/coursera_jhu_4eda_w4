library(plyr)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

png('plot6.png')

veh_index <- grepl("vehicle", tolower(scc$SCC.Level.Two))
scc_veh <- scc[veh_index,]$SCC

sub_veh<- nei[ nei$SCC %in% scc_veh,]
sub_veh_blmr <- sub_veh[sub_veh$fips == "24510",]
sub_veh_la <- sub_veh[sub_veh$fips == "06037",]

trend_blmr <- with(sub_veh_blmr, tapply(Emissions, year, sum, na.rm=T))
trend_blmr <- as.data.frame(trend_blmr)
names(trend_blmr) = c("Emissions")
trend_blmr$City = "Baltimore"
  
trend_la <- with(sub_veh_la, tapply(Emissions, year, sum, na.rm=T))
trend_la <- as.data.frame(trend_la)
names(trend_la) = c("Emissions")
trend_la$City = "Los Angeles"

trend <- rbind(trend_la,trend_blmr)
names(trend) <- c("Los Angeles", "Baltimore")

ggplot(trend,aes(row.names(trend), trend$Emissions, fill=City))+
  geom_bar(stat = "identity")+
  facet_grid(.~City, scales="free", space="free")+
  labs(x="Years", y="Total PM 2.5")

dev.off()
