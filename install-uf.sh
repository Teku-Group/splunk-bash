#!/bin/sh
  # Example file contents:
  # splunkuser@50.18.226.85
  HOSTS_FILE="UniversalForwarders"
  WGET_CMD="wget -O splunkforwarder-6.5.3-36937ad027d4-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.5.3&product=universalforwarder&filename=splunkforwarder-6.5.3-36937ad027d4-Linux-x86_64.tgz&wget=true'"
  INSTALL_FILE="splunkforwarder-6.5.3-36937ad027d4-Linux-x86_64.tgz"
  DEPLOY_SERVER="10.10.10.87:8089"
  PASSWORD="SPLKp@ss"
 
  REMOTE_SCRIPT="
  cd /opt
  sudo $WGET_CMD
  sudo tar -xzf $INSTALL_FILE
 
  sudo useradd -m -r splunk
  sudo chown -R splunk:splunk /opt/splunkforwarder
  echo $PASSWORD | sudo passwd splunk --stdin
  sudo -u splunk /opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --auto-ports --no-prompt
  sudo -u splunk /opt/splunkforwarder/bin/splunk set deploy-poll \"$DEPLOY_SERVER\" --accept-license --answer-yes --auto-ports --no-prompt  -auth admin:changeme
  sudo -u splunk /opt/splunkforwarder/bin/splunk edit user admin -password $PASSWORD -auth admin:changeme
  sudo -u splunk /opt/splunkforwarder/bin/splunk restart
  sudo /opt/splunkforwarder/bin/splunk enable boot-start -user splunk
  cd ~
  sudo rm -f /opt/$INSTALL_FILE
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
