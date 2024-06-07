#!/bin/bash

# Check if a domain name is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

# Assign the domain name provided as the argument
domain="$1"

# Create a folder on the desktop with the domain name
folder_path="$HOME/Desktop/$domain"
mkdir -p "$folder_path"

# Run subfinder to find subdomains
subfinder -d "$domain" -all -cs > "$folder_path/main.txt"

# Extract domain names from the output and save to domains.txt
cat "$folder_path/main.txt" | cut -d "," -f 1 > "$folder_path/domains.txt"

# Clean up the main.txt file
rm -rf "$folder_path/main.txt"

# Use httpx to gather more information about the subdomains
cat "$folder_path/domains.txt" | httpx -title -wc -sc -cl -ct -location -web-server -asn -o "$folder_path/httpx.txt"





# Use httpx to gather more information about the subdomains
cat "$folder_path/domains.txt" | httpx  -o "$folder_path/alive-subdomains.txt"


