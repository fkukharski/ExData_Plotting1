# zip_file and txt_file names with the UCI Electric power consumption Dataset
zip_file <- "exdata_data_household_power_consumption.zip"
txt_file <- "household_power_consumption.txt"

# downloading data set with exist-checking
if (!file.exists(txt_file)){
        if (!file.exists(zip_file)){
                zip_file_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(zip_file_URL, zip_file)
        }
        unzip(zip_file)
}

# reading 1/2/2007 and 2/2/2007 data
data <- read.table(txt_file, sep = ";", na.strings = "?", skip = 66637, nrows = 2880, 
                   col.names = strsplit(readLines(txt_file, n = 1), ";")[[1]])

# adding datetime column
data$datetime <- with(data, paste(Date, Time, sep = " "))
data$datetime <- as.POSIXct(data$datetime, format = "%d/%m/%Y %H:%M:%S")

# opening png graphics device
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# graphic
with(data, plot(datetime, Sub_metering_1, type = "n", xlab = "", 
                ylab = "Energy sub metering"))
with(data, lines(datetime, Sub_metering_1, col = "black"))
with(data, lines(datetime, Sub_metering_2, col = "red"))
with(data, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2)

# closing current plot
dev.off()
