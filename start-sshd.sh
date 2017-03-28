#!/bin/bash

# Note : requires elevated privileges (sudo)

SSHD_PATH=/usr/sbin/sshd
SSHD_CONFIG=./sftp_ng_proxy_sshd_config

DEBUG=""

if [[ $# -gt 0 && "$1" == "-d" || "$1" == "--debug" ]]; then
   echo "Starting sshd in debug mode."
   DEBUG="-d"
fi 


$SSHD_PATH $DEBUG -f $SSHD_CONFIG

