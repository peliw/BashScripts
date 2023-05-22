#!/bin/bash
#begir v3
# Ask the user for the number of concurrent connections
read -p "Enter the number of concurrent connections: " num
# Check if the input is a valid positive integer
if [[ $num =~ ^[1-9][0-9]*$ ]]; then
# Set the input file name
input_file="list.txt"
# Get the current date and time in YYYY-MM-DD_HH-MM-SS format
date_time=$(date +"%Y-%m-%d_%H-%M-%S")
# Create a directory with the date and time as the name
mkdir "$date_time"
# Get the log file name by adding .log to the input file name
log_file="$date_time/$input_file.log"
# Loop through each URL in the input file
while read url; do
# Get the file name from the URL using basename
file_name=$(basename "$url")
# Print the start time and URL to the log file
echo "Starting download of $url at $(date)" >> "$log_file"
# Download the file using axel with the given number of connections and save it to the directory
axel -n "$num" -o "$date_time/$file_name" "$url"
# Print the end time and URL to the log file
echo "Finished download of $url at $(date)" >> "$log_file"
done < "$input_file"
else
# Print an error message if the input is invalid
echo "Invalid input. Please enter a positive integer."
fi
