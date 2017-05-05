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
