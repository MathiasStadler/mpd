#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove
sudo apt-get install mpc mpd alsa-utils jack

#activate sound overlay
if grep --quiet overlays=analog-codec /boot/armbianEnv.txt; then
    echo "overlay already active"
    cat /boot/armbianEnv.txt
else
    echo overlay not found activate
    sudo su -p - root <<'EOF'
echo "overlays=analog-codec" >/boot/armbianEnv.txt
EOF
fi

#save org config file
sudo cp /etc/mpd.conf /etc/mpd.conf_org_install
#replace localhost with ip
sudo sed -i 's/localhost/127.0.0.1/g' /etc/mpd.conf
#restart
sudo service mpd restart
#set global name for playlist table
radio_station_file="/var/lib/mpd/playlists/radio.m3u"
#create playlist filr
sudo touch "${radio_station_file}"
# Bayern 3 Livestream High Quality (128 kbit/s)
# https://www.br.de/unternehmen/inhalt/technik/nutzung-mp3-livestreams-100.html
# add radio station to playlistm3u
sudo radio_station_file=${radio_station_file} su -p - root <<'EOF'
echo "${radio_station_file}"
ls -la "${radio_station_file}"
echo "http://streams.br.de/bayern3_2.m3u" >"${radio_station_file}"
EOF

sudo mpc load radio
sudo mpc play 1
