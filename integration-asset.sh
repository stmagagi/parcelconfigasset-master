#!/bin/bash
curl -O http:/192.168.50.11/images/mongodb.tar.gz
echo "Start load Dockerimage"
docker load -i mongodb.tar.gz
echo "Start load Dockerimage"
if [ ! "$(docker network ls | grep pcnetwork)" ]; then
  echo "Creating pcnetwork network ..."
  docker network create pcnetwork
else
  echo "pcnetwork network exists."
fi
echo "Network checked!"
echo "Docker container stop ..."
docker stop mongodb
echo "Docker container create ..."
docker run -p 27017:27017 --name="mongodb" --network="pcnetwork" -d mongodb
echo "Docker container running ..."
docker container prune -f
echo "Docker container pruned!"
