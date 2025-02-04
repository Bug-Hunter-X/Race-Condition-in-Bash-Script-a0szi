#!/bin/bash

# This script demonstrates a solution to the race condition.

# Create two files
touch file1.txt
touch file2.txt

# Create a function that adds content to a file using flock for locking
add_content() {
  local file=$1
  local content=$2
  flock -x "$file" || exit 1  # Acquire an exclusive lock on the file
  echo "$content" >> "$file"
  flock -u "$file"           # Release the lock
}

# Run the function sequentially using a lock
add_content file1.txt "Line 1"
add_content file2.txt "Line 2"

# Print content of file1 and file2
cat file1.txt
cat file2.txt