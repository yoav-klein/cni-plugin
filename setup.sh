#!/bin/bash

sudo apt-get update
sudo apt-get install -y jq

sudo cp my-cni-plugin /opt/cni/bin
sudo cp 10-cni-config.conflist /etc/cni/net.d
