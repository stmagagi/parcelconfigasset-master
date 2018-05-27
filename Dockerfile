FROM mongo:latest

EXPOSE 27017:27017

#COPY . /data/db

RUN mkdir -p /data/db \
    && echo "dbpath = /data/db" > etc/mongodb.conf \
    && chown -R mongodb:mongodb /data/db \
    && mongod --fork --logpath /var/log/mongodb.log --dbpath /data/db --smallfiles \
    && CREATE_FILES=/data/db/scripts