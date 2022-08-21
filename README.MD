# Headset Analog Loopback

This repository contains scripts and configurations to turn your Raspberry Pi into a realtime low-latency "translator" to convert between analog and digital signals for/to your USB headset.

## Why do I need this?
While in the past headsets were typically connected via analog cables to your soundcard on your computer more and more headsets are using digital audio transmission via USB. Additionally wireless headsets with USB dongles are getting more preset in the market.

Espeically wireless headsets often do not provide options to connect analog signals to/from the dongle. Your are trapped in a "USB ecosystem" where you need a fully functioning computer to send the audio signals to your wireless headset. Some people might want to connect their phone to their wireless USB headset. They would have to connect the phones audio to their PC and passthrough the audio from the Phone to the USB dongle. This requires that their PC is running all the time and needs special software on the PC.

Another problem occurs in the other direction, when the signal is generated from the headset and send to the computer. Some people (including me) are interested in combining this signal with existing audio processing hardware (mixer, equalizers, compressor, ...). These devices usually works on analog signals and are therefore not really compatible with the closed USB ecosystems of these headsets.

## Presented solution
The scrips in this repository allows you to setup a digital-analog and vice versa translator based on the Raspberry Pi hardware. The general idea is presented in the following figure.
The Pi takes the analog signal, processes and sends the digitized audio to the USB soundcard (dongle) of your headset. Vice versa it records the incoming audio stream form your headset (microphone) and passes the stream as an analog signal to an analog output.

![Audio routing](https://github.com/Wulkop/Headset-Analog-Loopback/blob/master/AudioPath.png)

## Prerequisites
### Hardware
* Raspberry Pi 3
* HifiBerry DAC+ADC
* SD Card
* USB Power
* Your USB Headset (of course :D)
### Software
* DietPi installed on the Raspberry Pi SD card (see [here](https://dietpi.com/docs/install/))


## Install
1. Copy the files in from the PI_ROOT folder in the root directory of your Pi (be careful!)
2. Install the packages `jackd, alsa_in and alsa_out`
3. Start Audioserver service: `sudo systemctl start audioserver.target`

Note: The udev rules filters in this package (/etc/udev/rules.d/82-audio-passthrough.rules) are designed and tested with the Corasir Virtoso RGB Wireless headset. The audioserver needs to be restarted when the device is reconnecting (e.g. after Standby mode). To automate this we are using udev rules which detects when the headset is connected/disconnected and restarts/stops the service. The filter of these udev rules needs to be changed if you are using a different headset.

## Technical facts:
* Mic stream is resampled with:
	* 1 channels
	* 48000 Hz
	* 128 Frames per Period
	* 3 Periods Buffer

* Audio stream is resampled with:
	* 2 channels
	* 48000 Hz
	* 128 Frames per Period
	* 3 Periods Buffer
* Main Jack Server is running on:
	* 2 channels
	* 48000 Hz
	* 64 Frames per Period
	* 1 Period Buffer
* These settings worked fine with very low latency (<5ms) on my Raspberry without any XRuns or dropped packages.



