# Checking and Reading PM2.5 Emission Data and Source Classification Table 
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

# Second question: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Subset the NEI of Baltimore using fips assign to its county
NEIBaltimore <- NEI[NEI$fips=="24510",]

# Aggregating total PM2.5 emissions at various years in Baltimore
aggregatedTotalBaltimore <- aggregate(Emissions ~ year, NEIBaltimore,sum)

# Exporting the result in PNG and setting resolution to 480X480
png("plot2.png",width=480,height=480,units="px")

# Constructing a bar plot showing Aggregated PM2.5 emissions in Baltimore
barplot(
  aggregatedTotalBaltimore$Emissions,
  names.arg=aggregatedTotalBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From All Sources in Baltimore City"
)

dev.off()