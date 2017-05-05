#!/bin/bash
set -e

PASSWD_FILE=/etc/vsftpd/passwd

echo > ${PASSWD_FILE}
FTP_USERS=()
while read user; do
  IFS=: read name pass <<< ${!user}
  mkdir -p "/ftp/${name}"
  echo -e "${name}:${pass}" >> ${PASSWD_FILE}
  echo "Added user ${name}"
  FTP_USERS+=(${name})  # Track all added users
done < <(env | grep "FTP_USER_" | sed 's/^\(FTP_USER_[a-zA-Z0-9]*\)=.*/\1/')

# Set permissions for FTP user
chown -R ftp:ftp /ftp
echo "Fixed permissions for all users"

echo "FTP Users: ${FTP_USERS[@]}"

exit 0
