#!/bin/bash
set -e

PASV_ADDRESS=${PASV_ADDRESS:-$(/sbin/ip route|awk '/default/ { print $3 }')}
echo "pasv_address=${PASV_ADDRESS}" >> /etc/vsftpd/vsftpd.conf

echo "Set pasv_address to ${PASV_ADDRESS}"
