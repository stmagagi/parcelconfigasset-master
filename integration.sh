#!/bin/bash
sudo curl -O http:/192.168.50.11/images/mongodb.tar.gz
sudo docker load -i mongodb.tar.gz

if [ ! "$(docker network ls | grep pcnetwork)" ]; then
  echo "Creating pcnetwork network ..."
  sudo docker network create pcnetwork
else
  echo "pcnetwork network exists."
fi

sudo docker run -p 27017:27017 --name="mongodb" --network="pcnetwork" -d mongodb
sudo docker container prune -f