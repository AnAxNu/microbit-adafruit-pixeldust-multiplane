#!/bin/bash

# Installer script for Adafruit PixelDust multiplane using
# electrodragon.com "RGB LED Matrix Panel Drive Board For Raspberry Pi"
# and rpi-rgb-led-matrix with an added mapper (Row-mapper)

CURRENT_PATH="$(pwd)/"
RPI_RGB_LED_MATRIX_REPRO=https://github.com/AnAxNu/rpi-rgb-led-matrix/archive/refs/heads/master.zip
ADAFRUIT_PIXELDUST_REPRO=https://github.com/AnAxNu/Adafruit_PixelDust/archive/refs/heads/pb-multiplane.zip
MICROBIT_SERIAL_REPRO=https://github.com/AnAxNu/microbit-serial/archive/refs/heads/master.zip

echo
echo "This script installs Adafruit PixelDust (multiplane) using"
echo "the electrodragon.com \"RGB LED Matrix Panel Drive Board For Raspberry Pi\""
echo "with the BBC MicroBit as accelerometer."
echo "Steps include:"
echo "- Install RGB matrix driver software"
echo "- Install Micro:Bit driver software"
echo "- Install Adafruit PixelDust (multiplane) software"
echo
echo "EXISTING INSTALLATION, IF ANY, WILL BE OVERWRITTEN."
echo
echo -n "CONTINUE? [y/n] "
read
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then
	echo "Canceled. "
	exit 0
fi

# rpi-rgb-led-matrix
echo
echo "Installing...."
echo
echo "*********************************************"
echo "Downloading/installing RGB matrix software..."
echo "*********************************************"
echo
curl -L $RPI_RGB_LED_MATRIX_REPRO -o rpi-rgb-led-matrix.zip
echo
unzip -q rpi-rgb-led-matrix.zip
rm rpi-rgb-led-matrix.zip
mv rpi-rgb-led-matrix-master rpi-rgb-led-matrix
echo "Building RGB matrix software..."
make -C ./rpi-rgb-led-matrix/lib

# MicroBit Serial
echo
echo
echo "**************************************************"
echo "Downloading/installing MicroBit Serial software..."
echo "**************************************************"
echo
curl -L $MICROBIT_SERIAL_REPRO -o microbit-serial.zip
echo
unzip -q microbit-serial.zip
rm microbit-serial.zip
mv microbit-serial-master microbit-serial
echo "Building MicroBit Serial software..."
make -C ./microbit-serial

# Adafruit PixelDust (multiplane)
echo
echo
echo "******************************************************************"
echo "Downloading/installing Adafruit PixelDust (multiplane) software..."
echo "******************************************************************"
echo
curl -L $ADAFRUIT_PIXELDUST_REPRO -o Adafruit_PixelDust-pb-multiplane.zip
echo
unzip -q Adafruit_PixelDust-pb-multiplane.zip
rm Adafruit_PixelDust-pb-multiplane.zip
echo "Building Adafruit PixelDust (multiplane) software..."
make -C ./Adafruit_PixelDust-pb-multiplane/raspberry_pi

# General info
echo
echo "Download/install is now complete."
echo
echo "If you have setup the MicroBit controller (./microbit-serial/board-src) you can now run the AdaFruit cube program:"
echo "sudo ./Adafruit_PixelDust-pb-multiplane/raspberry_pi/cube  --led-rows=64 --led-cols=64 --led-slowdown-gpio=4 --led-show-refresh --led-chain=2 --led-parallel=3 --led-pixel-mapper="Row-mapper" --led-brightness=40"
echo
echo "You might need to set permissions for the USB port, example: sudo chmod a+rw /dev/ttyACM0"
echo
echo "To test if the MicroBit communication is working you can run: ./microbit-serial/microbit-serial-test"
echo


