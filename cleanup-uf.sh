#!/bin/sh
  # Example file contents:
  # splunkuser@50.18.226.85
  HOSTS_FILE="UniversalForwarders"
 
  REMOTE_SCRIPT="
  sudo /opt/splunkforwarder/bin/splunk disable boot-start
  sudo -u splunk /opt/splunkforwarder/bin/splunk stop
  sudo rm -rf /opt/splunkforwarder
  sudo userdel splunk
  sudo groupdel splunk
  "    
 
  echo "Starting."
  for DST in `cat "$HOSTS_FILE"`; do
    if [ -z "$DST" ]; then
      continue;
    fi
    echo "---------------------------"
    echo "Installing to $DST"
    sudo ssh -i SPLK.pem -t "$DST" "$REMOTE_SCRIPT"
  done  
  echo "---------------------------"
  echo "Done"
