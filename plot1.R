# Checking and Reading PM2.5 Emission Data and Source Classification Table 
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

# First question: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for
# each of the years 1999, 2002, 2005, and 2008.

# Aggregating total PM2.5 emissions at various years in US
aggregatedTotal <- aggregate(Emissions ~ year, NEI, sum)

# Exporting the result in PNG and setting resolution to 480X480
png("plot1.png",width=480,height=480,units="px")

# Constructing a bar plot showing Aggregated PM2.5 emissions in USA in megaTons
barplot(
  (aggregatedTotal$Emissions)/10^6,
  names.arg=aggregatedTotal$year,
  xlab="Year",
  ylab="PM2.5 Emissions (megaTons)",
  main="Total PM2.5 Emissions From All Sources in United States"
)

dev.off()