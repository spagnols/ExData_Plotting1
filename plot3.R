## constants
n_days <- 2
mins_per_hour <- 60
hours_per_day <- 24
mins_per_day <- mins_per_hour*hours_per_day
POSIXct_date1 <- as.POSIXct("2007-02-01 00:00:00") ##1st date/time to include

## extract 1st row and its date/time
initial <- read.table("household_power_consumption.txt", nrows = 1,
                      sep = ";", header = TRUE)
firsttime <- paste(levels(initial$Date),levels(initial$Time))
POSIXct_init <- as.POSIXct(strptime(firsttime, format = "%d/%m/%Y %H:%M:%S"))

## calculate number of lines to skip before 1st considered date/time
diff <- POSIXct_date1 - POSIXct_init
skip_length <- as.numeric(diff)*mins_per_day

## read table (2 days: 2007-02-01/02 + header)
tab <- read.table("household_power_consumption.txt", skip = skip_length,
                  nrows = mins_per_day*n_days, sep = ";",
                  header = TRUE, na.string="?")
names(tab) <- names(initial)

## plot lines, change x-axis labels, add legend and save as png
plot(tab$Sub_metering_1, ylab = "Energy sub metering", xlab="", xaxt="n",
     type="l", col="black")
lines(tab$Sub_metering_2, col="red")
lines(tab$Sub_metering_3, col="blue")
axis(1, c(1,mins_per_day+1,mins_per_day*2+1), c("Thu", "Fri", "Sat"))
legend("topright", lty = 1, cex = 0.9, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png")
dev.off()
