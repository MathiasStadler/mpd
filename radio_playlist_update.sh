#!/bin/bash -e

# credits to
# http://blog.scphillips.com/posts/2014/05/bbc-radio-on-the-raspberry-pi-v2/

# This script is based on one found in what is assumed to be the public domain.

set -e
playlist=/tmp/radio.m3u
rm -f $playlist
 
declare -A radios

radios["BBC1"]="http://streams.br.de/bayern3_1.m3u"
 
for k in "${!radios[@]}"
do
	pls=${radios[$k]}
	#curl -s $pls | grep File1 | sed "s/File1=/$k, /" >> "$playlist"
    curl -s $pls >> "$playlist"
done
