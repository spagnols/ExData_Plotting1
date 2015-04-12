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

## create plot, change x-axis labels and save as png
plot(tab$Global_active_power, ylab = "Global Active Power (kilowatts)",
     xlab="", xaxt="n", type="l")
axis(1, c(1,mins_per_day+1,mins_per_day*2+1), c("Thu", "Fri", "Sat"))
dev.copy(png, file = "plot2.png")
dev.off()
