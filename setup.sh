#!/bin/bash

sudo apt-get update
sudo apt-get install jq

sudo cp my-cni-plugin /opt/cni/bin
sudo cp 11-cni-config.json /etc/cni/net.d
