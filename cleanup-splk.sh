#!/bin/sh
  # Example file contents:
  # splunkuser@50.18.226.85
  HOSTS_FILE="SplunkCore"
  PASSWORD="SPLKp@ss"
 
  REMOTE_SCRIPT="
  sudo /opt/splunk/bin/splunk disable boot-start
  sudo -u splunk /opt/splunk/bin/splunk stop
  rm -rf /opt/splunk
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
