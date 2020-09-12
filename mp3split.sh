#!/bin/bash

###############################################################
# Functions definition 
###############################################################

get_time_stamp () {
  # Get the end timestamp and convert it to mp3splt format
  echo "$(echo $1 | cut -d' ' -f1)"
}

extract_track (){
  # Set these global variables
  start="$(get_time_stamp ${trackpair[0]})" 
  end="$(get_time_stamp ${trackpair[1]})" 
  tracktitle="$(echo "${trackpair[0]}" | cut -d' ' -f 2-)"
  
  # If track is the last to process
  if [ "$1" = "last" ]; then
    start="${end}" 
    end="${audioduration}"
    tracktitle="$(echo "${trackpair[1]}" | cut -d' ' -f 2-)"
  fi
  
  outfile="$tracktitle.$ext"
  
  # Begin splitting files with ffmpeg
  [ ! "$simulate" = true ] && ffmpeg -nostdin -y -loglevel error -i "$inputaudio" -ss "$start" -to "$end" -acodec copy "$outfile"

  echo "Processed $start to $end; $outfile"
}

###############################################################
# Script arguments
###############################################################

usage() { 
echo "Usage:
  mp3split [OPTIONS] inputaudio tracklist
Options: 
  -s: do a simulation without writing anything to disk
  -h: print this help

  The script will output all the splitted files in the 
  current/working directory." && exit 1 ;}

while getopts "hs" o; do 
  case "${o}" in
    s) simulate=true ;;
    h) usage ;;
    *) printf "Invalid option: -%s\\n" "$OPTARG" && usage ;;
  esac 
done

shift $((OPTIND-1))

###############################################################
# Main body 
###############################################################

# Check for initial errors
[ ! -f "$2" ] && printf "The first file should be the audio, the second should be the timecodes.\\n" && exit

# Validate if ffmpeg is installed
! command -v ffmpeg &> /dev/null && echo "ffmpeg is not installed" && exit 1

ext="mp3"
inputaudio="$1"
tracklist="$2"

# Get total duration of inputaudio
audioduration="$(ffprobe -i "$inputaudio" -show_entries format=duration -v quiet -of csv='p=0' -sexagesimal)"

countr=0

printf "\n=== Begin to create mp3 split files ===\n"

# Read from tracklist line by line
while read -r tracklistline;
do
  if [ "$countr" -ge 2 ]; then 
    countr=1
    extract_track
    trackpair[0]="${trackpair[1]}"
  fi
  
  # Assign a line to the array
  trackpair["$countr"]="$tracklistline"
  
  # Increment countr
  countr="$((countr+1))"
  
done < "$tracklist"

# Process the last two tracks
extract_track
extract_track last
