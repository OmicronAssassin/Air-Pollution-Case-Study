library(ggplot2)

# Checking and Reading PM2.5 Emission Data and Source Classification Table 
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

# Third question: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

# Subset the NEI of Baltimore using fips assign to its county
NEIBaltimore <- NEI[NEI$fips=="24510",]

# Aggregating total PM2.5 emissions at various years in Baltimore
aggregatedTotalBaltimore <- aggregate(Emissions ~ year, NEIBaltimore,sum)

# Exporting the result in PNG and setting resolution to 480X480
png("plot3.png",width=480,height=480,units="px")

# Bar plot comparison showing various emission sources in Baltimore CIty
ggp <- ggplot(NEIBaltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  theme() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y=expression("Total PM2.5 Emission (Tons)")) + 
  ggtitle("PM2.5  Emissions in Baltimore City by Source Type") +
  theme(plot.title = element_text(hjust = 0.5))

print(ggp)

dev.off()

