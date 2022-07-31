#!/bin/bash
#
# Copyright 2022, luftegrof at duck dot com
#
# Licensed under GPL Version 3
# See LICENSE file for info.
#
# This script pings the specified IP address.  If loss is detected, a traceroute to that address will be executed and logged to ${HOME}/pftg.log.

#   - It sends probes at a 0.2 second interval.  
#   - It waits 0.2 seconds for a response.  
#   - It sends 1472 bytes of data with each probe.
#   - It sends 10 probes.
#   - If 10 responses haven't been received within 2 seconds, it exits with code 1.

/bin/ping -q -n -i 0.2 -W 0.2 -s 1472 -c 10 -w 2 -O ${1}
if [ $? -eq 0 ]; then
        exit
elif [ $? -eq 1 ]; then
        printf "%s\n" "Loss detected. Executing traceroute."
        printf "\n" >> ${HOME}/pftg.log
        printf "%s\n" "$(date) $(date +'%s')" "Packet Loss Detected in the path to ${1}.  Tracing the route." >> ${HOME}/pftg.log
        /usr/bin/traceroute -m 15 -q 10 -w 1 ${1} >> ${HOME}/pftg.log
        printf "\n" >> ${HOME}/pftg.log
else
        printf "%s\n" "Unrecognized exit code from ping.  Does not compute."
fi
