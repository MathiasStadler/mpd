#!/bin/bash -e

# credits to
# http://blog.scphillips.com/posts/2014/05/bbc-radio-on-the-raspberry-pi-v2/

# This script is based on one found in what is assumed to be the public domain.

set -e
URLS=/tmp/radio.m3u
#from here => https://stackoverflow.com/questions/3183444/check-for-valid-link-url
REGEX_VALID_URL='(https?|http|ftp|file):\/\/[-A-Za-z0-9\+&@#\/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#\/%=~_|]'

finish_error() {
    echo -e "\e[31m CREATE {$URLS} FILE FAILED.\e[0m"
	echo -e "\e[31m errexit on line $(caller) \e[0m" >&2
    exit -1
 }
 trap finish_error ERR

[ -e "${URLS}" ] && rm ${URLS}

declare -A radios

radios["Bayern3_lowquality"]="http://streams.br.de/bayern3_1.m3u"
radios["Bayern3_highquality"]="http://streams.br.de/bayern3_2.m3u"
 
for k in "${!radios[@]}"
do
	pls=${radios[$k]}
	#curl -s $pls | grep File1 | sed "s/File1=/$k, /" >> "$URLS"
    curl -s $pls >> "$URLS" | (head -n1 && tail -n1)
	echo "" >> "$URLS"
done


# I would to like only  the first line
sed -i -n '1p' /tmp/radio.m3u

#test file available
[ ! -e "${URLS}" ] &&  { echo -e "\e[31mError file ${URLS} NOT available.\e[0m"; finish_error ;}

echo "htttp://br-br3-live.cast.addradio.de/br/br3/live/mp3/56/stream.mp3" >> "${URLS}"

#!/bin/bash
_line_count=0;
while read _line; do
_line_count=$(( _line_count + 1 ))
  if [[ $_line =~ ${REGEX_VALID_URL} ]] ; then 
  #TODO in grün
  	echo -e  "${_line_count} => ${_line} OK"; 
  else 
	echo -e  "\e[31m${_line_count} => ${_line} NOT OK\e[0m";
	finish_error; 
  fi
done <"${URLS}"


#TODO static final vars  => readonly CONSTVAR=value
#TODO log helper script  => FILE=/path/to/some/file ; [ -f $FILE ] && . $FILE