#!/bin/bash

containers='
[
{
    "ns_name": "blue",
    "container_id": "milky_road",
    "if_name": "veth0"
},
{
    "ns_name": "red",
    "cotainer_id": "little_bastard",
    "if_name": "veth0"
}
]
'

clean() {
    local containers_parsed=$(echo $containers | jq -c '.[]')
    for container in $container_parsed; do
        ns_name=$(echo $container | jq -r ".ns_name")
        sudo ip netns delete "$ns_name"
    done
    
    sudo rm -rf /var/run/netns/*
}

test_add() {
    config=$(cat 10-cni-config.json)
    derived=$(echo $config | jq '. += .plugins[0] | del(.plugins)')
    
    local containers_parsed=$(echo $containers | jq -c '.[]')
    
    for container in $containers_parsed; do
        ns_name=$(echo $container | jq -r ".ns_name")
        CNI_CONTAINERID=$(echo $container | jq -r ".container_id")
        CNI_IFNAME=$(echo $container | jq -r ".if_name")

        sudo ip netns | grep "$ns_name" || sudo ip netns add "$ns_name"
        export CNI_COMMAND=ADD
        export CNI_NETNS="/var/run/netns/$ns_name"
        export CNI_CONTAINERID
        export CNI_IFNAME

        echo $derived | sudo -E ./my-cni-plugin
    done

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
