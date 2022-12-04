#!/bin/bash



test_add() {
    echo "=== Testing add"
    config=$(cat 10-cni-config.json)
    derived=$(echo $config | jq '. += .plugins[0] | del(.plugins)')
    
    # create אthe red namespace
    sudo ip netns | grep "red" || sudo ip netns add red

    export CNI_COMMAND=ADD
    export CNI_NETNS=/var/run/netns/red
    export CNI_CONTAINERID="mynewcontainer"
    export CNI_IFNAME="veth0"

    echo $derived | sudo -E ./my-cni-plugin
}


usage() {
    echo "./test.sh add/del"
}

case $1 in
add) test_add ;;
del) test_del ;;
*) usage
esac
