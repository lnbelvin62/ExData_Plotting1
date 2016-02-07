# Note - I used grep to extract the two days specified in the project
# instructions (February 1, 2007 and February 2, 2007) so that my data
# file has only 2,880 rows of data (plus one for the header strings)
# and 9 columns, rather than using the full data set of 2,075,259 rows,
# so that my code execution time was greatly reduced.  The file that
# contains the two days of data is called "hpc_subset.txt" (hpc stands
# for household power consumption).

library(chron)

# The instructions are to create a PNG plot with a width of 480 pixels
# and a height of 480 pixels.  Those are the defaults for the
# "png()" function, so all that is required is the PNG file name.
png(filename = "plot2.png")

# Read in the household power consumption data file.  It is a plain text
# file that uses semicolons to separate the values / columns.
hpc_data <- read.table("hpc_subset.txt", sep = ";", header = TRUE,
                       colClasses = c("character", "character", "numeric",
                                      "numeric", "numeric", "numeric",
                                      "numeric", "numeric", "numeric"))

# The x-axis of the required plot is the date / time across the two day
# period of the (subsetted) data.  We need to create a datetime object
# for plotting.
hpc_datetime = chron(dates=hpc_data$Date, times=hpc_data$Time,
                     format = c(dates = "d/m/y", times = "h:m:s"))

# Plot global active power versus time without the x-axis ticks or labels.
plot(hpc_datetime, hpc_data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")

# Set the positions for the x-axis ticks.
positions <- c(13545, 13546, 13547)

# Set the labels for the x-axis ticks.
day_labels = c("Thu", "Fri", "Sat")

# Add / annotate the x-axis ticks and labels to the plot.
axis(side = 1, at = positions, labels = day_labels)

# Close the PNG file that was opened above.
dev.off()
