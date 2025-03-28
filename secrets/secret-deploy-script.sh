#!/bin/bash

# Create the namespace if it doesn't exist
kubectl get namespace finxpert-dev >/dev/null 2>&1 || kubectl create namespace finxpert-dev

# Get the directory where this script is located
SCRIPT_DIR="$(dirname "$0")"

# Define the directory containing the actual secret scripts (relative to the script's own directory)
SECRET_SCRIPTS_DIR="$SCRIPT_DIR/secrets"

# Check if the directory exists
if [ -d "$SECRET_SCRIPTS_DIR" ]; then
    echo "Switching to directory: $SECRET_SCRIPTS_DIR"
    cd "$SECRET_SCRIPTS_DIR" || { echo "Failed to change directory to $SECRET_SCRIPTS_DIR"; exit 1; }

    # Loop through each script file in the inner secrets directory and execute it
    for script in *.sh; do
        if [ -f "$script" ]; then
            echo "Executing $script..."
            bash "$script"
            echo "$script executed."
        else
            echo "No script files found in $SECRET_SCRIPTS_DIR."
        fi
    done

    echo "All secrets have been deployed."
else
    echo "Directory $SECRET_SCRIPTS_DIR does not exist. Exiting..."
    exit 1
fi
