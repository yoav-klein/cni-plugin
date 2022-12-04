#!/bin/bash

ns_name="blue"
cntainer_id="mynewcontainer"
if_name="veth0"

clean() {
    sudo ip netns delete "$ns_name"
    sudo rm -rf /var/run/netns/*
}

test_add() {
    echo "=== Testing add"
    config=$(cat 10-cni-config.json)
    derived=$(echo $config | jq '. += .plugins[0] | del(.plugins)')
    
    # create אthe red namespace
    sudo ip netns | grep "$ns_name" || sudo ip netns add "$ns_name"

    export CNI_COMMAND=ADD
    export CNI_NETNS="/var/run/netns/$ns_name"
    export CNI_CONTAINERID="$container_id"
    export CNI_IFNAME="$if_name"

    echo $derived | sudo -E ./my-cni-plugin
}


usage() {
    echo "./test.sh add/del"
}

case $1 in
add) test_add ;;
del) test_del ;;
clean) clean ;;
*) usage
esac
