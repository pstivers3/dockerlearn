#!/bin/bash

# Bug: Agent won't connet word press.

export CLIENT_ID=dockerinaction

if [ ! -n "$CLIENT_ID" ]; then
    echo "Client ID not set"
    exit 1
fi

DB_CID=$(docker create -e MYSQL_ROOT_PASSWORD=ch2demo mysql:5.7)
docker start $DB_CID

MAILER_CID=$(docker create dockerinaction/ch2_mailer)
docker start $MAILER_CID

WP_CID=$(docker create  --link $DB_CID:mysql --name wp_$CLIENT_ID -p 80 --read-only -v /run/apache2/ --tmpfs /tmp \
    -e WORDPRESS_DB_NAME=$CLIENT_ID wordpress:5.0.0-php7.2-apache)
docker start $WP_CID

AGENT_CID=$(docker create --name agent_$CLIENT_ID --link $WP_CID:insideweb \
    --link $MAILER_CID:insidemailer dockerinaction/ch2_agent)
docker start $AGENT_CID

echo -e "\ntail the agent log, follow for a few seconds"
docker logs --tail 5 -f $AGENT_CID &
sleep 5 

echo -e "\nremove containers"
docker rm -f $AGENT_CID $WP_CID $MAILER_CID $DB_CID

