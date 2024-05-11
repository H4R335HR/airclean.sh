#!/usr/bin/env bash
#Requires aircrack-ng to run

# Define a function to handle user input
handle_input() {
    # If the input contains a question mark, provide input as "1"
    if [[ $1 == *"?"* ]]; then
        echo "1"
    fi
}

# Iterate over each file in /root/handshakes/
for file in /root/handshakes/*.pcap; do
    # Run aircrack-ng on the file and provide input as "1" when prompted
    output=$(aircrack-ng "$file" <<< "$(handle_input "$output")")
    
    # Check if the output contains "(1 handshake)" or "with PMKID"
    if ! echo "$output" | grep -q -E "(1 handshake|with PMKID)"; then
        # If it doesn't, remove the file
        rm "$file"
    fi
done
