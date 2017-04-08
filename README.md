# splk-bash
Automated bash scripts for Splunk deployments


#cleanup-splk.sh
This file will un-install Splunk Enterprise binaries unstalled under /opt/splunk

#cleanup-uf.sh
This file will un-install Splunk Universal Forwarder binaries unstalled under /opt/splunkforwarder

#install-idx.sh
This file will install Splunk Enterprise binaries and set listening to 9997

#install-splk.sh
This file will just install Splnuk Enterprise binaries and won't set any unique settings - use this as a base for Search Head or Indexer or Heavy Forwarders

#install-uf.sh
This file will install Splunk Universal Forwarder binaries unstalled under /opt/splunkforwarder
--This sets the deploy server and needs to be set in the variables

Search Heads:
Once deplpoyed you need to add peers:
splunk add search-server https://192.168.1.1:8089 -auth admin:password -remoteUsername admin -remotePassword passremote

Then create outputs to turn off local indexing and forward to index teir
