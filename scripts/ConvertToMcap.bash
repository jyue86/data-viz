#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_folder> <output_folder>"
    exit 1
fi

INPUT_FOLDER="$1"
OUTPUT_FOLDER="$2"

# Ensure the output folder exists
mkdir -p "$OUTPUT_FOLDER"

# Iterate through all ROS2 bag files in the input folder
for BAG_FILE in "$INPUT_FOLDER"/*.db3; do
    if [ -f "$BAG_FILE" ]; then
        # Extract the base name of the file (without extension)
        BASE_NAME=$(basename "$BAG_FILE" .db3)
        OUTPUT_FILE="$OUTPUT_FOLDER/$BASE_NAME.mcap"

        echo "Converting $BAG_FILE to $OUTPUT_FILE..."
        ./scripts/mcap convert "$BAG_FILE" "$OUTPUT_FILE"

        if [ $? -eq 0 ]; then
            echo "Successfully converted $BAG_FILE to $OUTPUT_FILE"
        else
            echo "Failed to convert $BAG_FILE" >&2
        fi
    fi # End of the if statement
done

echo "Conversion process completed."