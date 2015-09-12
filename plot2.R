## Load the necessary libraries
library(lubridate)
## Retrieve the data
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "/tmp/household-data-set.zip",
              method = "wget",
              quiet = TRUE
)
unzip("/tmp/household-data-set.zip", exdir = "/tmp")
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
## Create a synthetic date-time column
householdData$FullDate <- paste(householdData$Date, householdData$Time)
householdData$FullDate <- dmy_hms(householdData$FullDate)
## Coerce factor in appropriate data types where necessary
householdData$Date <- as.Date(dmy(householdData$Date))
householdData$Global_active_power <- as.numeric(
      as.character(
            householdData$Global_active_power
      )
)
## Grab the dates we actually care about
workingData <- householdData[
      householdData$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")), 
      ]
## Create the plot
png(filename = "/tmp/plot2.png")
plot(workingData$FullDate, 
     workingData$Global_active_power, 
     type = "l", 
     xlim = range(workingData$FullDate), 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()