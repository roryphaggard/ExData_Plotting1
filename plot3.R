## Load the necessary libraries
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
## Coerce the data into its proper data types
## Create a synthetic date-time column
householdData$FullDate <- paste(householdData$Date, householdData$Time)
householdData$FullDate <- dmy_hms(householdData$FullDate)
## Coerce factor in appropriate data types where necessary
householdData$Date <- as.Date(dmy(householdData$Date))
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
png(filename = "/tmp/plot3.png")
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
     col = "red",     
     ylab = "",
     xlab = "",
     axes = F)
par(new=T)
plot(workingData$FullDate, 
     workingData$Sub_metering_3, 
     type = "l", 
     col = "blue",     
     ylab = "",
     xlab = "",
     axes = F)
par(new=T)
legend("topright", 
       lty = c(1,1), 
       lwd = c(2,2), 
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Submetering_3"), 
       col = c("black","red","blue"))
dev.off()