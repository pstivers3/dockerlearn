#!/bin/bash

MAILER_CID=$(docker run -d dockerinaction/ch2_mailer)

WEB_CID=$(docker run -d nginx)

AGENT_CID=$(docker run -d --link ${WEB_CID}:insideweb --link ${MAILER_CID}:insidemailer dockerinaction/ch2_agent)

echo -e "\ntail the agent log, follow for a few seconds"
docker logs --tail 5 -f $AGENT_CID &
sleep 5 

echo -e "\nremove containers"
docker rm -f $MAILER_CID $WEB_CID $AGENT_CID
