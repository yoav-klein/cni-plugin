# CNI Plugin
---

This is a simple implementation of a CNI plugin, not near to a production-level one.

It is based on this YouTube video:
https://www.youtube.com/watch?v=zmYxdtFzK6s

## Usage
---
We'll assume you are using some cloud environment, say Azure.

### Install the CNI plugin on the nodes
After (or before) installing kubernetes and containerd on the hosts, you need
to install the CNI plugin. This is comprised of the _Network Configuration_ - `10-cni-config.conflist`,
and the CNI plugin itself - `my-cni-plugin`.

Just clone this repo in each of the nodes (including control plane nodes), and in each of them,
change the third part of the `.plugins[0].podCidr` - `10.240.1.0/24`, `10.240.2.0/24`, etc.
After changing it, run the `setup.sh` script, and you are good to go.

### Setting up routes in the subnet
In Azure (I'm not sure it this is true for AWS), there is no layer 2 connectivity between nodes.
This means you can't set up routing using the route tables on the hosts themselves.

What this means is, you need to set up routing for the subnet in the Azure portal (or somehow programatically).

Basically what you need to do is to set up an entry in the routing table for each worker node, so that
the IP range that is set up for this node will be routed to the node.

For example, say you have a node named `worker1`, and when you installed the plugin you gave it `podCidr: 10.240.3.0/24`,
then you need to set up a route in the routing table that all traffic destined to `10.240.3.0/24` will be routed
to `worker1`.

## Ansible
We have a playbook for installing kubernetes in our `ansible` repository. This playbook has an option
to install this CNI plugin. If you choose this, the playbook will clone this repository in each of the nodes,
and render the template `10-cni-config.conflist.j2` and set up a `podCidr` automatically for each host.

Just make sure that if you change something in the 10-cni-config.conflist`, you also change it in `10-cni-config.conflist.j2`

