#! /bin/sh

. ${HOME}/dot-bashrc
# This is simply informative output to the system logger
logger "$USER is SFTP-casting to $SFTP_HOST at `date`"

# Note we pick up local system env variables to help select which key to
# authenticate with, and to which host to connect.
# Definition of relevant user env variables can be established in the usual
# places, e.g. .bashrc
/usr/bin/ssh -l $USER -i "/home/$USER/.ssh/$USER@$SFTP_HOST" -s $SFTP_HOST sftp

# NB - it is also possible, via the SendVar option (man ssh_config), to define
# an environment variable on the remote system, once the ssh session is set up.
# This could be used, e.g. pass 1-time auth token to the SFTP daemon. 
