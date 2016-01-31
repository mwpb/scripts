#!/bin/bash
strip_uid=$(echo "$1" | cut -d 'U' -f 1 | cut -d ',' -f 1) 
full_source="$2/$1"
full_target="/Users/mat/@cantab/Documents/cur/$strip_uid"
mv $full_source $full_target
