#!/bin/bash



test_add() {
    echo "=== Testing add"
    config=$(cat 10-cni-config.json)
    derived=$(echo $config | jq '. += .plugins[0] | del(.plugins)')

    echo $derived | sudo CNI_COMMAND=ADD ./my-cni-plugin
}


usage() {
    echo "./test.sh add/del"
}

case $1 in
add) test_add ;;
del) test_del ;;
*) usage
esac
