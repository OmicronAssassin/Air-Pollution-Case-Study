library(ggplot2)

# Checking and Reading PM2.5 Emission Data and Source Classification Table 
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

# Fifth question: How have emissions from motor vehicle sources changed
# from 1999–2008 in Baltimore City?

# Subset motor vehicle related emission NEI data
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCCvehicles <- SCC[vehicle,]$SCC
NEIvehicles <- NEI[NEI$SCC %in% SCCvehicles,]

# Subset Baltimore City motor vehicle related emission NEI data
NEIBaltimoreVehicles <- NEIvehicles[NEIvehicles$fips=="24510",]

# Exporting the result in PNG and setting resolution to 480X480
png("plot5.png",width=480,height=480,units="px")

# Bar plot showing motor vehicle source emissions in Baltimore City
ggp <- ggplot(NEIBaltimoreVehicles,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey43",width=0.5) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="Year", y=expression("Total PM2.5 Emission (Tons)")) + 
  ggtitle("PM2.5 Motor Vehicle Source Emissions in Baltimore City") +
  theme(plot.title = element_text(hjust = 0.5))

print(ggp)

dev.off()