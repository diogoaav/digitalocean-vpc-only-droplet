#!/bin/bash

# This script is designed to be executed after cloud-init on an Ubuntu machine.
# It discovers the current gateway address, deletes the default route, adds a new default route with the specified gateway on interface eth1,
# and configures a static route for the metadata IP address (169.254.169.254/32) with the next hop being the current gateway.

# Function to retrieve the current gateway address
get_current_gateway() {
    ip route show default | awk '/default/ {print $3}'
}

# Function to delete the current default route
delete_default_route() {
    ip route del default
}

# Function to add a new default route
add_default_route() {
    ip route add default via $1 dev eth1
}

# Function to configure a static route for the metadata IP address
configure_metadata_route() {
    ip route add 169.254.169.254/32 via $1
}

# Main script
current_gateway=$(get_current_gateway)

if [ -n "$current_gateway" ]; then
    echo "Current gateway: $current_gateway"
    
    delete_default_route
    echo "Deleted the default route"
    
    new_gateway="10.116.0.20"
    add_default_route $new_gateway
    echo "Added new default route via $new_gateway on eth1"
    
    configure_metadata_route $current_gateway
    echo "Configured static route for metadata IP (169.254.169.254/32) via $current_gateway"
else
    echo "No current gateway found."
fi