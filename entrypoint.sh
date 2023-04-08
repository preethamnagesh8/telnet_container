#!/bin/bash

# Define a function to start the telnetd service
start_telnetd() {
    /usr/sbin/in.telnetd -debug 23
}

# Start the telnetd service
start_telnetd

# Define a function to start the health check server
start_health_check() {
    # Install Python 3 and pip
    apt-get update && apt-get install -y python3 python3-pip

    # Install Flask
    pip3 install flask

    # Define the Flask app
    python3 /app/health_check.py &
}

# Start the health check server in the background
start_health_check &

# Loop until the telnetd service exits
while true; do
    # Wait for the telnetd service to exit
    wait $!

    # Restart the telnetd service
    start_telnetd
    start_health_check
done

