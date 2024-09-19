#!/bin/bash

# Set the base directory




#!/bin/bash

# Set the base directory
BASE_DIR="/Users/soham/Downloads/iRouteMapNew"

# Find and process all 'Audio.wav' files
find "$BASE_DIR" -type f -name "Audio.wav" | while IFS= read -r file; do
    echo "Processing: $file"
    
    # Convert the audio file and save it as a temporary file with .wav extension
    #ffmpeg -y -i "$file" -ar 44100 -ac 2 -c:a pcm_s16le "$file.tmp.wav"
    ffmpeg -y -i "$file" -ar 44100 -ac 1 -c:a pcm_s16le -af "loudnorm=I=-16:TP=-1.5:LRA=11, volume=20dB" "$file.tmp.wav"
     
    # Check if conversion was successful
    if [ $? -eq 0 ]; then
        # Replace the original file with the converted file
        mv "$file.tmp.wav" "$file"
        echo "Successfully converted: $file"
    else
        # Remove the temporary file if conversion failed
        rm "$file.tmp.wav"
        echo "Failed to convert: $file"
    fi
done
