#!/bin/bash 
sudo phing -f /usr/local/lib/papache/papache.xml -Dvhost="$2" $1
