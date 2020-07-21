library(ggplot2)

# Checking and Reading PM2.5 Emission Data and Source Classification Table 
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

# Fourth question: Across the United States, how have emissions from coal  
# combustion-related sources changed from 1999–2008?

# Subset coal and combustion related NEI data
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)

coalCombustion <- (coal & combustion)

SCCcombustion <- SCC[coalCombustion,]$SCC
NEIcombustion <- NEI[NEI$SCC %in% SCCcombustion,]

# Exporting the result in PNG and setting resolution to 480X480
png("plot4.png",width=480,height=480,units="px")

# Bar plot showing aggregate total emissions from coal sources
ggp <- ggplot(NEIcombustion,aes(factor(year),Emissions/10^6)) +
  geom_bar(stat="identity",fill="grey43",width=0.5) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM2.5 Emission (megaTons)")) +
  ggtitle("PM2.5 Coal Combustion Source Emissions Across United States") +
  theme(plot.title = element_text(hjust = 0.5))

print(ggp)

dev.off()