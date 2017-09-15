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

      This repository contains the following pieces that are useful for SFTP-casting:

### sftp_ng_proxy_sshd_config
      Configuration file for local SSH daemon; uses custom "Subsystem" config entry to invoke shell 
script instead of default sftp server.

### sftp-ng-cast.sh
      Example shell script that, when invoked from an SSH "Subsystem", will forward an inbound SFTP  session to a 
remote host. Uses Unix user environment variables to customize connectivity logic.

### dot-bashrc
      Example Unix user bash resource script. Serves as a place to define environment variables that
may be picked up by sftp-cast.sh, after SSH authenticates a user, to customize connectivity logic.

## Running
      You will need two instances of sshd running to test this process: a front-end proxy sshd (running on a custom port) and the ultimate sshd you wish to connect to for SFTP (system sshd in this example).

1) Start the system sshd instance running on usual port 22.

2) Start the front-end SFTP proxy sshd instance; use the start script in this repo (start-sshd.sh)

3) Copy the custom proxy jump script (sftp-ng-cast.sh) from this repo to the expected path from the sftp_ng_proxy_sshd_config, /usr/local/sbin

4) Identify a user you wish to test jump with. This user is going to need two prep items: one, copy the 'dot-bashrc' shell script from this repo to the test users $HOME directory, and two, create/repurpose an ssh key pair for the user to authenticate to the 2nd sshd with, and put this key pair in test user's .ssh directory, as well as in their authorized_keys file.

5) Now, open a normal SFTP session to the proxy sshd instance, using either password or key auth. You'll utilize the proxy sshd custom port like 'sftp -P 2246 test_user@localhost'

6) If you reach an sftp prompt, then you've achieved success! You are now effectively "tunneled" between your client, the sshd proxy and the system sshd, inside of an SFTP session.

## Next Steps

   * Insert call out to a provider of SFTP account rules (e.g. IP whitelist, connection limiting) into sftp-cast.sh
   * Insert call out to a provider of an authorization token service (LDAP, JWT) into sftp-cast.sh
   * Including passing of any user-specific environment variables to downstream SFTP host, using ssh "SendVar" option.
   * More TBD?
