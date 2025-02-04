#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Create a function that adds content to a file
add_content() {
  local file=$1
  local content=$2
  echo "$content" >> "$file"
}

# Run the function concurrently for file1 and file2
add_content file1.txt "Line 1"
&  #Run in background
add_content file2.txt "Line 2"
&  #Run in background
wait #Wait for both to finish

# Print content of file1 and file2
cat file1.txt
cat file2.txt