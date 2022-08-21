#!/bin/bash
jack_connect system:capture_1 alsa_out:playback_1
jack_connect system:capture_2 alsa_out:playback_2

jack_connect alsa_in:capture_1 system:playback_1
jack_connect alsa_in:capture_1 system:playback_2
 exit 0
