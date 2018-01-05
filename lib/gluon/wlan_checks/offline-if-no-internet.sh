#!/bin/sh
# idea stolen from https://github.com/Freifunk-Troisdorf/gluon-ssid-changer/blob/master/files/lib/gluon/ssid-changer/ssid-changer.sh

UPPER_LIMIT='55' #Above this limit the online SSID will be used
LOWER_LIMIT='45' #Below this limit the offline SSID will be used
# In-between these two values the SSID will never be changed to preven it from toggeling every Min

#Is there an active Gateway?
GATEWAY_TQ=`batctl gwl | grep "^=>" | awk -F'[()]' '{print $2}'| tr -d " "` #Grep the Connection Quality of the Gateway which is currently used
if [ ! $GATEWAY_TQ ]; #If there is no gateway there will be errors in the following if clauses
then
	GATEWAY_TQ=0 #Just an easy way to get an valid value if there is no gatway
fi

if [ $GATEWAY_TQ -gt $UPPER_LIMIT ];
then
	echo "Gateway TQ is $GATEWAY_TQ node is online"
	if [ "`iwinfo`" == "" ]; then
	  /sbin/wifi
	fi
fi

if [ $GATEWAY_TQ -lt $LOWER_LIMIT ];
then
	echo "Gateway TQ is $GATEWAY_TQ node is considered offline"
	  /sbin/wifi down
fi
