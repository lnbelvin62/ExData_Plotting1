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
png(filename = "plot4.png")

# Read in the household power consumption data file.  It is a plain text
# file that uses semicolons to separate the values / columns.
hpc_data <- read.table("hpc_subset.txt", sep = ";", header = TRUE,
                       colClasses = c("character", "character", "numeric",
                                      "numeric", "numeric", "numeric",
                                      "numeric", "numeric", "numeric"))

# We want 4 plots on the same screen in 2 rows by 2 columns.
par(mfrow = c(2, 2))

# Set the margins a little smaller than the defaults in order to be able to
# fit all 4 plots comfortably on one page / screen.
par(mar = c(4, 4, 2, 2))

# The x-axis of the required plot is the date / time across the two day
# period of the (subsetted) data.  We need to create a datetime object
# for plotting.
hpc_datetime = chron(dates=hpc_data$Date, times=hpc_data$Time,
                     format = c(dates = "d/m/y", times = "h:m:s"))



# Plot #1 (upper left corner).

# Plot global active power versus time without the x-axis ticks or labels.
plot(hpc_datetime, hpc_data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power", xaxt = "n")

# Set the positions for the x-axis ticks.
positions <- c(13545, 13546, 13547)

# Set the labels for the x-axis ticks.
day_labels = c("Thu", "Fri", "Sat")

# Add / annotate the x-axis ticks and labels to the plot.
axis(side = 1, at = positions, labels = day_labels)


# Plot #2 (upper right corner).

# Plot voltage versus time without the x-axis ticks or labels.
plot(hpc_datetime, hpc_data$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage", xaxt = "n")

# Set the positions for the x-axis ticks.
positions <- c(13545, 13546, 13547)

# Set the labels for the x-axis ticks.
day_labels = c("Thu", "Fri", "Sat")

# Add / annotate the x-axis ticks and labels to the plot.
axis(side = 1, at = positions, labels = day_labels)


# Plot #3 (lower left corner).

# Determine the limit for the y-axis.
y_limit = range(c(hpc_data$Sub_metering_1, hpc_data$Sub_metering_2,
                  hpc_data$Sub_metering_3))

# Plot sub metering 1 versus time without either axis ticks or labels.
plot(hpc_datetime, hpc_data$Sub_metering_1, type = "l",
     xlab = "", xaxt = "n", ylab = "", yaxt = "n", ylim = y_limit)

# Plot sub metering 2 versus time without either axis ticks or labels.
par(new = TRUE)
plot(hpc_datetime, hpc_data$Sub_metering_2, type = "l", col = "red",
     xlab = "", xaxt = "n", ylab = "", yaxt = "n", ylim = y_limit)

# Plot sub metering 3 versus time without the x-axis ticks or labels.
par(new = TRUE)
plot(hpc_datetime, hpc_data$Sub_metering_3, type = "l", col = "blue",
     xlab = "", xaxt = "n", ylab = "Energy sub metering", yaxt = "n",
     ylim = y_limit)

# Set the positions for the x-axis ticks.
x_positions <- c(13545, 13546, 13547)

# Set the labels for the x-axis ticks.
day_labels = c("Thu", "Fri", "Sat")

# Set the positions for the y-axis ticks.
y_positions <- c(0, 10, 20, 30)

# Set the labels for the y-axis ticks.
y_labels = c("0", "10", "20", "30")

# Add / annotate the x-axis ticks and labels to the plot.
axis(side = 1, at = x_positions, labels = day_labels)

# Add / annotate the y-axis ticks and labels to the plot.
axis(side = 2, at = y_positions, labels = y_labels)

# Add the legend.  Note that there is no box around this legend -
# unlike the case for plot 3.
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Plot #4 (lower right corner).

# Plot global reactive power versus time without the x-axis ticks or labels.
plot(hpc_datetime, hpc_data$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power",
     xaxt = "n", yaxt = "n")

# Set the positions for the x-axis ticks.
positions <- c(13545, 13546, 13547)

# Set the labels for the x-axis ticks.
day_labels = c("Thu", "Fri", "Sat")

# Set the positions for the y-axis ticks.
y_positions <- c(0, 0.1, 0.2, 0.3, 0.4, 0.5)

# Set the labels for the y-axis ticks.
y_labels <- c("0.0", "0.1", "0.2", "0.3", "0.4", "0.5")

# Add / annotate the x-axis ticks and labels to the plot.
axis(side = 1, at = positions, labels = day_labels)

# Add / annotate the y-axis ticks and labels to the plot.
# The "0.1", "0.3", and "0.5" tick labels did not appear on the plot
# until I set cex.axis to 0.9 (slightly smaller than normal font).
axis(side = 2, at = y_positions, labels = y_labels, cex.axis = 0.9)

# Close the PNG file that was opened above.
dev.off()
