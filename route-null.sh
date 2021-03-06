#!/bin/sh
# Adds an IP to null route
# Requirements: ip route
# Expect: srcip
# Copyright (C) 2015-2020, Wazuh Inc.
# Author: Ivan Lotina
# Modifyed script host-deny from Daniel B. Cid
# Last modified: Feb 16, 2007

ACTION=$1
USER=$2
IP=$3

LOCAL=`dirname $0`;
cd $LOCAL
cd ../
PWD=`pwd`
LOCK="${PWD}/host-deny-lock"
LOCK_PID="${PWD}/host-deny-lock/pid"

UNAME=`uname`

# Logging the call
echo "`date` $0 $1 $2 $3 $4 $5"


# IP Address must be provided
if [ "x${IP}" = "x" ]; then
   echo "$0: Missing argument <action> <user> (ip)" 
   exit 1;
fi


# Adding the ip to null route
if [ "x${ACTION}" = "xadd" ]; then
  if [ "X${UNAME}" = "XLinux" ]; then
   route add ${IP} reject
   exit 0;
  fi

  if [ "X${UNAME}" = "XFreeBSD" ]; then
   route -q add ${IP} 127.0.0.1 -blackhole
   exit 0;
  fi

# Deleting from null route
# be carefull not to remove your default route
elif [ "x${ACTION}" = "xdelete" ]; then   
  if [ "X${UNAME}" = "XLinux" ]; then
   route del ${IP} reject
   exit 0;
  fi

  if [ "X${UNAME}" = "XFreeBSD" ]; then
   route -q delete ${IP} 127.0.0.1 -blackhole
   exit 0;
  fi

# Invalid action   
else
   echo "$0: invalid action: ${ACTION}"
fi       

exit 1;
