#!/bin/bash
set -e

PASV_MIN_PORT=${PASV_MIN_PORT:-21000}
PASV_MAX_PORT=${PASV_MAX_PORT:-21010}

echo "pasv_max_port=${PASV_MAX_PORT}" >> /etc/vsftpd/vsftpd.conf
echo "pasv_min_port=${PASV_MIN_PORT}" >> /etc/vsftpd/vsftpd.conf

echo "Set passive range to ${PASV_MIN_PORT}:${PASV_MAX_PORT}"
