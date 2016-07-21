#!/bin/bash

# Encode a WAV to a finalized podcast MP3 with metadata, in the current directory
# Requires lame
# With Homebrew on Mac OS X: brew install lame

if [ "$#" -ne 4 ]; then
    echo "USAGE: ./encode-podcast.sh input_aiff episode_number title summary"
    exit 1
fi

SHOW_AUTHOR="Pincount"

EPISODE_NUMBER=$2
EPISODE_TITLE=$3
EPISODE_SUMMARY=$4

INPUT_WAV_FILE=$1

# Artwork: ideally 1400x1400, but less than 128 KB to maximize compatibility
ARTWORK_JPG_FILENAME="${HOME}/Dropbox/Pincount/mp3Artwork.jpg"

# Output quality (kbps): 96 or 64 recommended
MP3_KBPS=96

lame --noreplaygain --cbr -h -b $MP3_KBPS --resample 44.1 --tt "$EPISODE_NUMBER: $EPISODE_TITLE" --tc "$EPISODE_SUMMARY" --ta "$SHOW_AUTHOR" --tl "$SHOW_AUTHOR" --ty `date '+%Y'` --ti "$ARTWORK_JPG_FILENAME" --add-id3v2 "$INPUT_WAV_FILE" "${INPUT_WAV_FILE%%.aiff}.mp3"

say "encode complete"
