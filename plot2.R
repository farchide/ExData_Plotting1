url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
td = tempdir()
tf = tempfile(tmpdir=td, fileext=".zip")

download.file(url, tf)

fname = unzip(tf, list=TRUE)$Name[1]
unzip(tf, files=fname, exdir=td, overwrite=TRUE)
fpath = file.path(td, fname)
plotdata <- read.table(fpath, header = TRUE,sep=";",na.strings="?")
plotsubset <- subset(plotdata, plotdata$Date >= as.Date("2007-2-1","%Y-%m-%d") & plotdata$Date <= as.Date("2007-2-2","%Y-%m-%d"))
install.packages("chron")
library(chron)
dateandtime <- chron(as.character(plotsubset$Date),plotsubset$Time,format = c(dates = "Y-m-d", times = "h:m:s"))
plot(dateandtime,plotsubset$Global_active_power,type="l",ylab="Global Active Power(kilowatts)",xlab="")
dev.copy(png, file = "plot2.png")
dev.off()