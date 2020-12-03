#!/bin/bash

MAILER_CID=$(docker run -d dockerinaction/ch2_mailer)

WEB_CID=$(docker run -d nginx)

AGENT_CID=$(docker run -d --link ${WEB_CID}:insideweb --link ${MAILER_CID}:insidemailer dockerinaction/ch2_agent)

echo -e "\ntail the agent log"
docker logs --tail 5 -f $AGENT_CID &
sleep 5 

echo -e "\nstop the log tail"
kill $(ps -ef | grep 'logs --tail' | grep -v grep | awk '{print $2}')
sleep 1

echo -e "\nremove containers"
docker rm -f $MAILER_CID $WEB_CID $AGENT_CID
