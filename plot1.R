## Load the necessary libraries
library(lubridate)
## Retrieve the data
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              ddestfile = "/tmp/household-data-set.zip",
              method = curl,
              quiet = TRUE
)
unzip("/tmp/household-data-set.zip")
## Read in the data
## NB: factor chosen to speed initial read
householdData <- read.table(
      "/tmp/household_power_consumption.txt", 
      header = TRUE,
      sep = ";", 
      colClasses = c("factor",
                     "factor",
                     "factor",
                     "factor",
                     "factor",
                     "factor",
                     "factor",
                     "factor",
                     "factor"),
      nrows = 2075260
)
## Coerce the needful data into its proper data types
householdData$Date <- as.Date(dmy(householdData$Date))
householdData$Time <- hms(householdData$Time)
householdData$Global_active_power <- as.numeric(
      as.character(
            householdData$Global_active_power
      )
)
## Grab the data for the dates we actually care about
workingData <- householdData[
      householdData$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")), 
      ]
## Create the plot
png(filename = "/tmp/plot1.png")
hist(workingData$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()