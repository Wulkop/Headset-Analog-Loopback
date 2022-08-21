#! /bin/bash

export JACK_NO_AUDIO_RESERVATION=1
#Start jackd service
taskset 1 /usr/bin/jackd -R -P 95 -dalsa -dhw:sndrpihifiberry -r48000 -p32 -n4 -s --hwmon --hwmeter &

sleep 1
#Start audio in
taskset 2 alsa_in -dhw:Gamin,0 -r48000 -p32 -n6 -c1 -q0&

sleep 1

taskset 3 alsa_out -dhw:Gamin,0 -r48000 -p32 -n6 -q0&

sleep 1

jack_connect system:capture_1 alsa_out:playback_1 &
jack_connect system:capture_2 alsa_out:playback_2 &

jack_connect alsa_in:capture_1 system:playback_1 &
jack_connect alsa_in:capture_1 system:playback_2 &
