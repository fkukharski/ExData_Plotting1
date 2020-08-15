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

data <- read.table(txt_file, sep = ";", na.strings = "?", skip = 66637, nrows = 2880, 
                   col.names = strsplit(readLines(txt_file, n = 1), ";")[[1]])

png(filename = "plot1.png", width = 480, height = 480, units = "px")

hist(data$Global_active_power, main = "Global Active Power", col = "red", 
     xlab = "Global Active Power (kilowatts)")

dev.off()
