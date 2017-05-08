# vsftpd in Docker

[vsftp](https://security.appspot.com/vsftpd.html)

## Adding users

Users are configured through environmental variables.

The following would create two users: `hi` and `bye`, each with their own password (same as the username) and chroot environment. It does not matter what you call the ENV variables as long as each matches `^FTP_USER_[a-zA-Z0-9]*=user:pass`

```
FTP_USER_001=hi:GlYSFzEaoZovo
FTP_USER_002=bye:4aS6bYB/ZU7Ao
```

The passwords should be crypt()ed and supported by the [libpam-pwdfile](https://github.com/tiwe-de/libpam-pwdfile) module. All of these generation methods work:

```bash
$ openssl passwd --table -crypt hi bye
hi      $1$yzM/s.6Y$picjCfeP4lK6HBxJHEWw41
bye     $1$bK5gT30J$ECANQa9XPfwtjlcYIsNi10

$ openssl passwd --table -1 hi bye
hi      t4jLb9WOiAP1A
bye     qqbP1ddNr8/5I

$ mkpasswd hi && mkpasswd bye
GlYSFzEaoZovo
4aS6bYB/ZU7Ao
```

## Configuration

For passive FTP connections to work you will need to set the `PASV_ADDRESS` env variable to the external IP of the host server. This will default to the private docker IP address `$(/sbin/ip route|awk '/default/ { print $3 }')`.

You can see the min and max passive ports to use via `PASV_MIN_PORT` and `PASV_MAX_PORT`

## Sample run

```bash
$ git clone https://github.com/axiom-data-science/docker-vsftpd.git
$ docker build -t vsftpd .
$ docker run --rm -it --env-file users.env -e PASV_ADDRESS=127.0.0.1 -p 1020-1021:20-21 -p 21000-21010:21000-21010 -v $(pwd)/srv:/ftp --name vsftpd vsftpd
$ bash test.sh
```
