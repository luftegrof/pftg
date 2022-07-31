# pftg
Ping Fail Trace Get

Copyright 2022, luftegrof at duck dot com

Licensed under GPL Version 3
See LICENSE file for info.

This script pings the specified IP address.  If loss is detected, a traceroute to that address will be executed and logged to ${HOME}/pftg.log.

  - It sends probes at a 0.2 second interval.  
  - It waits 0.2 seconds for a response.  
  - It sends 1472 bytes of data with each probe.
  - It sends 10 probes.
  - If 10 responses haven't been received within 2 seconds, it exits with code 1.
