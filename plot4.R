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
## Coerce the data into its proper data types
householdData$Date <- as.Date(dmy(householdData$Date))
householdData$Time <- hms(householdData$Time)
householdData$Global_active_power <- as.numeric(
      as.character(
            householdData$Global_active_power
      )
)
householdData$Global_reactive_power <- as.numeric(
      as.character(
            householdData$Global_reactive_power
      )
)
householdData$Global_intensity <-  as.numeric(
      as.character(
            householdData$Global_intensity
      )
)
householdData$Voltage <-  as.numeric(
      as.character(
            householdData$Voltage
      )
)
householdData$Sub_metering_1 <- as.numeric(
      as.character(
            householdData$Sub_metering_1
      )
)
householdData$Sub_metering_2 <- as.numeric(
      as.character(
            householdData$Sub_metering_2
      )
)

householdData$Sub_metering_3 <- as.numeric(
      as.character(
            householdData$Sub_metering_3
      )
)

## Grab the dates we actually care about
workingData <- householdData[
      householdData$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")), 
      ]
## Create the plot
png(filename = "/tmp/plot4.png")
par(mfrow = c(2,2))
### Upper left histogram
hist(workingData$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)"
     )
### Upper right line graph
plot(workingData$FullDate, 
     workingData$Voltage, 
     type = "l", 
     xlim = range(workingData$FullDate), 
     xlab = "datetime",
     ylab = "Voltage"
     )
### Lower left multi-line graph
plot(workingData$FullDate, 
     workingData$Sub_metering_1, 
     type = "l", 
     xlim = range(workingData$FullDate),
     ylim = range(workingData$Sub_metering_1),
     ylab = "Energy sub metering",
     xlab = ""
     )
par(new=T)
plot(workingData$FullDate, 
     workingData$Sub_metering_2, 
     type = "l",
     ylim = range(workingData$Sub_metering_1),
     col = "red",     
     ylab = "",
     xlab = "",
     axes = F
     )
par(new=T)
plot(workingData$FullDate, 
     workingData$Sub_metering_3, 
     type = "l", 
     ylim = range(workingData$Sub_metering_1),
     col = "blue",     
     ylab = "",
     xlab = "",
     axes = F
     )
par(new=T)
legend("topright", 
       lty = c(1,1), 
       lwd = c(2,2), 
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Submetering_3"), 
       col = c("black","red","blue")
       )
### Lower right line graph
plot(workingData$FullDate, 
     workingData$Global_active_power, 
     type = "l", 
     xlim = range(workingData$FullDate), 
     xlab = "datetime",
     ylab = "Global_reactive_power"
     )
dev.off()