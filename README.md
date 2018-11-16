# mpd

- mpd play local radio station BAYERN3 on OrangePiZero

## Motivation

- listen loacal radio station BAYERN 3 on Orange Pi Zero

## ENV

- Linux orange pi zero 4.14.12-sunxi #1 SMP Tue Jan 9 13:53:33 UTC 2018 armv7l GNU/Linux
- [Armbian OS](https://github.com/armbian/build)
- Armbian build from source with help of  https://github.com/MathiasStadler/armbian-sunxi-fel-boot

## Credits / Sources

- https://www.feldspaten.org/2014/04/raspberry-als-internet-radio-station/ 


## OrangePiZero

- [orange pi zero](http://www.orangepi.org/orangepizero/)
  -- 512 MByte version
- [Orange Pi Zero Expansion board  Interface board](https://www.aliexpress.com/item/New-Orange-Pi-Zreo-Expansion-board-Interface-board-Development-board-beyond-Raspberry-Pi/32770665186.html)

## Bayern3 (bavaria radio station) radio stream address

- https://www.br.de/unternehmen/inhalt/technik/nutzung-mp3-livestreams-100.html

## install software

```bash
sudo apt update && sudo apt upgrade && sudo apt autoremove
sudo apt install mpc mpd alsa-utils

```

## enable expansion board for audio and usb

- save org file

```bash
sudo cp /boot/armbianEnv.txt /boot/armbianEnv_org_install.txt
```

- uncomment  exist overlays

```bash
sudo sed -i '/overlays/s/^/#/g' /boot/armbianEnv.txt
```

- add necessary overlays and spi bus parameter

```bash
cat << EOF | sudo tee -a /boot/armbianEnv.txt
overlays=analog-codec usbhost2 usbhost3 spi-spidev
param_spidev_spi_bus=0
EOF

# reboot the sbc
sudo shutdown -Fr now

```

## set hostname ( nice to have)

```bash
# set
sudo systemctl hostname set opi-radio
# check
sudo systemctl hostname
# reboot sbc
sudo shutdown -Fr now
```

## start radio

```bash
# status mpd should running
sudo systemctl status mpd
# start radio
mpc add http://br-br3-live.cast.addradio.de/br/br3/live/mp3/128/stream.mp3 
mpc play 1
```

## enable auto start after restart ( safely)

- append mpc to /etc/rc.local

```bash
cat << EOF |sudo tee -a /etc/rc.local
# auto start radio
( sleep 30 && mpc add http://br-br3-live.cast.addradio.de/br/br3/live/mp3/128/stream.mp3 && mpc play 1 ) &
EOF
```

## control loudspeaker volumes

```bash
# max volumes
/usr/bin/amixer set 'Line Out' 100% unmute
# NEVER use 100% of any technical device :-)
# better
# max volumes
/usr/bin/amixer set 'Line Out' 90% unmute
```

## add another radio station

```bash
# add Deutschlandfunk
mpc add http://st01.dlf.de/dlf/01/128/mp3/stream.mp3
mpc play 2
```

