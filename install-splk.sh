#!/bin/sh
  # Example file contents:
  # splunkuser@50.18.226.85
  HOSTS_FILE="SplunkCore"
  WGET_CMD="wget -O splunk-6.5.3-36937ad027d4-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.5.3&product=splunk&filename=splunk-6.5.3-36937ad027d4-Linux-x86_64.tgz&wget=true'"
  INSTALL_FILE="splunk-6.5.3-36937ad027d4-Linux-x86_64.tgz"
  PASSWORD="SPLKp@ss"
 
  REMOTE_SCRIPT="
  cd /opt
  sudo $WGET_CMD
  sudo tar -xzf $INSTALL_FILE
 
  sudo useradd -m -r splunk
  sudo chown -R splunk:splunk /opt/splunk
  echo $PASSWORD | sudo passwd splunk --stdin
  sudo -u splunk /opt/splunk/bin/splunk start --accept-license --answer-yes --auto-ports --no-prompt
  sudo -u splunk /opt/splunk/bin/splunk edit user admin -password $PASSWORD -auth admin:changeme
  sudo -u splunk /opt/splunk/bin/splunk restart
  sudo /opt/splunk/bin/splunk enable boot-start -user splunk
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
