# sftp-ng-proxy : Forwarding of Local SFTP Session to Remote Host
***
## Purpose

This is a collection of system scripts and config files that can be utilized to forward connection
of a local SFTP session (brokered via sshd) to a remote host. The remote host could be providing a standard
SFTP server via OpenSSH, or the remote host could be offering our customized SFTP daemon (s3ftp).

To describe this process differently, it is a means of providing an "SSH proxying" feature set so that a
front-end SSH daemon can recieve requests for SFTP sessions and forward them to downstream servers, based on
characteristics (SSH account name, environment variables) of the connecting user.

## Contents

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This repository contains the following pieces that are useful for SFTP-casting:

### sftp_ng_proxy_sshd_config
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Configuration file for local SSH daemon; uses custom "Subsystem" config entry to invoke shell 
script instead of default sftp server.

### sftp-ng-cast.sh
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Example shell script that, when invoked from an SSH "Subsystem", will forward an inbound SFTP  session to a 
remote host. Uses Unix user environment variables to customize connectivity logic.

### dot-bashrc
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Example Unix user bash resource script. Serves as a place to define environment variables that
may be picked up by sftp-cast.sh, after SSH authenticates a user, to customize connectivity logic.

## Next Steps

   * Insert call out to a provider of SFTP account rules (e.g. IP whitelist, connection limiting) into sftp-cast.sh
   * Insert call out to a provider of an authorization token service (LDAP, JWT) into sftp-cast.sh
   * Including passing of any user-specific environment variables to downstream SFTP host, using ssh "SendVar" option.
   * More TBD?
