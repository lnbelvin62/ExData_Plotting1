# Note - I used grep to extract the two days specified in the project
# instructions (February 1, 2007 and February 2, 2007) so that my data
# file has only 2,880 rows of data (plus one for the header strings)
# and 9 columns, rather than using the full data set of 2,075,259 rows,
# so that my code execution time was greatly reduced.  The file that
# contains the two days of data is called "hpc_subset.txt" (hpc stands
# for household power consumption).

# The instructions are to create a PNG plot with a width of 480 pixels
# and a height of 480 pixels.  Those are the defaults for the
# "png()" function, so all that is required is the PNG file name.
png(filename = "plot1.png")

# Read in the household power consumption data file.  It is a plain text
# file that uses semicolons to separate the values / columns.
hpc_data <- read.table("hpc_subset.txt", sep = ";", header = TRUE,
                       colClasses = c("character", "character", "numeric",
                                      "numeric", "numeric", "numeric",
                                      "numeric", "numeric", "numeric"))

# Plot a histogram of the "global active power" (the third column
# of the hpc data).  Set the fill bars to be red, and set the title
# and x-axis label as specified in the project instructions.
hist(hpc_data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Close the PNG file that was opened above.
dev.off()
