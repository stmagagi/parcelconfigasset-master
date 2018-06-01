#!/bin/bash
curl -O http:/192.168.50.11/images/mongodb.tar.gz
docker load -i mongodb.tar.gz

if [ ! "$(docker network ls | grep pcnetwork)" ]; then
  echo "Creating pcnetwork network ..."
  docker network create pcnetwork
else
  echo "pcnetwork network exists."
fi

docker run -p 27017:27017 --name="mongodb" --network="pcnetwork" -d mongodb
docker container prune -f