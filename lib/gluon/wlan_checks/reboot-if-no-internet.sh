#!/bin/sh

LOWER_LIMIT='45' #Below this limit reboot

#Is there an active Gateway?
GATEWAY_TQ=`batctl gwl | grep "^=>" | awk -F'[()]' '{print $2}'| tr -d " "` #Grep the Connection Quality of the Gateway which is currently used
if [ ! $GATEWAY_TQ ]; #If there is no gateway there will be errors in the following if clauses
then
	GATEWAY_TQ=0 #Just an easy way to get an valid value if there is no gatway
fi

if [ $GATEWAY_TQ -lt $LOWER_LIMIT ];
then
	echo "Gateway TQ is $GATEWAY_TQ node is considered offline"
	  reboot
fi
