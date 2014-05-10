url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
td = tempdir()
tf = tempfile(tmpdir=td, fileext=".zip")

download.file(url, tf)

fname = unzip(tf, list=TRUE)$Name[1]
unzip(tf, files=fname, exdir=td, overwrite=TRUE)
fpath = file.path(td, fname)
plotdata <- read.table(fpath, header = TRUE,sep=";",na.strings="?")
plotdata$Date <- as.Date(plotdata$Date,"%d/%m/%Y")

plotsubset <- subset(plotdata, plotdata$Date >= as.Date("2007-2-1","%Y-%m-%d") & plotdata$Date <= as.Date("2007-2-2","%Y-%m-%d"))

hist(plotsubset$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (Kilowatts)",ylim=range(0,1200))
dev.copy(png, file = "plot1.png")
dev.off()