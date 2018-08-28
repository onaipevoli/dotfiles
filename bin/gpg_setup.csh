#!/bin/tcsh -x

set gpg_info=~/.gpg-agent-info

# Exit if gpg-agent is not found
which gpg-agent >> /dev/null || exit

if (-f ${gpg_info}) then
  # Set environment variables for gpg-agent
  eval `gawk -F = '{print "setenv", $1, $2, ";"}' < ${gpg_info}`
  setenv GPG_TTY `tty`

  # Check if pgp-agent is certainly running. If yes, exit the script
  set gpg_id=`echo ${GPG_AGENT_INFO} | sed -e 's/.*gpg-agent:\([^:]*\):.*$/\1/'`
  # echo ${gpg_id}
  set cmd=`ps -p ${gpg_id} -o comm=`
  # echo ${cmd}
  if (${cmd} == "gpg-agent") then
    # echo "gpg-agent is running"
    exit
  endif
endif

# Run gpg-agent
# This command leaves veariable setting in ~/.gpg-agent-info for other login processes
eval `gpg-agent --daemon --write-env-file`

