#!/bin/bash

cd
docker pull lscr.io/linuxserver/transmission:latest
docker pull dperson/samba
docker pull linuxserver/plex:latest

docker-compose up -d

docker system prune -af

echo $(date) >> docker-compose-update.log