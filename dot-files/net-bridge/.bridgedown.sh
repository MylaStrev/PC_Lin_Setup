#!/bin/bash


nmcli connection down bridge-slave-eno1
echo "bridge slave down"

nmcli connection down bridge-br0
nmcli connection up wired
echo "wired up"
