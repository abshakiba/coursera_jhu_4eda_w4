library(plyr)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

png('plot4.png')

comb_index <- grepl("comb", tolower(scc$SCC.Level.One))
coal_index <- grepl("coal", tolower(scc$SCC.Level.Four))
scc_comb_coal <- scc[comb_index & coal_index,]$SCC

sub_coal <- nei[ nei$SCC %in% scc_comb_coal,]

trend <- with(sub_coal, tapply(Emissions, year, sum, na.rm=T))
trend <- as.data.frame(trend)
names(trend) = c("Emissions")
  
ggplot(trend,aes(row.names(trend), trend$Emissions))+
  geom_bar(stat = "identity")

dev.off()
