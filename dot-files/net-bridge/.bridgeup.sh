#!/bin/bash

nmcli connection up bridge-br0
echo "br0 up"

nmcli connection up bridge-slave-eno1
echo "bridge slave done"
