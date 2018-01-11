# mpd
mpd play loacal radio station Bayern3 on OrangePiZero

# Motivation 
- listen loacal radio station BAYERN 3 on Orange Pi Zero


# ENV
- Linux orangepizero 4.14.12-sunxi #1 SMP Tue Jan 9 13:53:33 UTC 2018 armv7l GNU/Linux
- Armbian OS  build with  https://github.com/armbian/build
- with help of  https://github.com/MathiasStadler/armbian-sunxi-fel-boot




# Credits / Sources
- https://www.feldspaten.org/2014/04/raspberry-als-internet-radio-station/ 


# OrangePiZero
- http://www.orangepi.org/orangepizero/
- 512 MByte version


# Bayern3 radio stream address
- https://www.br.de/unternehmen/inhalt/technik/nutzung-mp3-livestreams-100.html


# install 

sudo apt-get update 
sudo apt-get upgrade
sudo apt-get autoremove
sudo apt-get install mpc mpd alsa-utils
sudo cp /etc/mpd.conf /etc/mpd.conf_org_install
sudo sed -i 's/localhost/127.0.0.1/g' /etc/mpd.conf

radio_station_file = "/var/lib/mpd/playlists/radio.m3u"
sudo touch "${radio_station_file}"
sudo "" > 




# config 






# Error / Hint

### Error
- bash: warning: setlocale: LC_ALL: cannot change locale (de_DE.UTF-8)
- bash: warning: setlocale: LC_ALL: cannot change locale (de_DE.UTF-8)

### Solution
- source last entry
- https://github.com/singularityware/singularity/issues/11

- ```echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8 ```

- log out / log in


### Error
mpc play 1 => mpd error: Bad song index
### Solution
playlist file empty or empty line



### Error
alsa_mixer: Failed to read mixer for 'My ALSA Device': failed to attach to default: No such file or directory
### Solution
open




### Error
- soure :: https://bbs.archlinux.org/viewtopic.php?id=164932
aplay -l shows => aplay: device_list:270: no soundcards found...
### Solution

- https://forum.armbian.com/topic/4909-how-to-start-a-sound/
- https://forum.armbian.com/topic/4714-how-do-i-make-arecord-work-in-mainline-opi-zero/?tab=comments#comment-35741
- https://forum.armbian.com/topic/1960-configuring-orange-pi-pc-for-analogue-line-out-jack-audio-output-and-simultaneous-hdmi-output-with-software-mixing/


### Error
cannot open mixer: No such file or directory
### Solution
- https://askubuntu.com/questions/800863/alsamixer-returns-cannot-open-mixer-no-such-file-or-directory
- https://wiki.ubuntuusers.de/JACK/
sudo apt install jack
sudo lspci -v | grep -i audio returns



# other
mpv $(youtube-dl -g "<url>")


github.com/alexa-pi/AlexaPi. 




mixer_type software



# speaker-test - command-line speaker test tone generator for ALSA 
- > speaker-test




service rsyslog status




# ffmepeg -formats




http://blog.scphillips.com/posts/2014/05/bbc-radio-on-the-raspberry-pi-v2/
https://github.com/scp93ch/raspberry-radio/blob/master/scripts/radio