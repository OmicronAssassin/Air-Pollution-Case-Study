library(ggplot2)

# Checking and Reading PM2.5 Emission Data and Source Classification Table 
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

# Sixth question: Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California. Which city has seen greater changes 
# over time in motor vehicle emissions?

# Gather the subset of the NEI data which corresponds to vehicles
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCCvehicles <- SCC[vehicle,]$SCC
NEIvehicles <- NEI[NEI$SCC %in% SCCvehicles,]

# Subset Baltimore City motor vehicle related emission NEI data
NEIBaltimoreVehicles <- NEIvehicles[NEIvehicles$fips=="24510",]
NEIBaltimoreVehicles$city <- "Baltimore City"

# Subset Los Angeles County motor vehicle related emission NEI data
NEILAVehicles <- NEIvehicles[NEIvehicles$fips=="06037",]
NEILAVehicles$city <- "Los Angeles County"

# Combine the two subsets into one data frame
NEIcombined <- rbind(NEIBaltimoreVehicles,NEILAVehicles)

# Exporting the result in PNG and setting resolution to 480X480
png("plot6.png",width=480,height=480,units="px")

ggp <- ggplot(NEIcombined, aes(x=factor(year), y=Emissions/10^3, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="Year", y=expression("Total PM2.5 Emission (kiloTons)")) + 
  ggtitle("PM2.5 Motor Vehicle Source Emissions in Baltimore City and LA County") +
  theme(plot.title = element_text(hjust = 0.5))

print(ggp)

dev.off()