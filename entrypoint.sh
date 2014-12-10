#!/bin/bash

# If we were given arguments, run them instead
if [ $? -gt 1 ]; then
  exec "$@"
fi

# Start up mongod
/local/mongodb-linux-x86_64-2.6.5/bin/mongod -replSet rs0 --dbpath /data --logpath /logs/mongo --fork
sleep 2
echo 'rs.initiate()' | /local/mongodb-linux-x86_64-2.6.5/bin/mongo

# start up elasticsearch
cd /local/elasticsearch-1.4.0 
./bin/elasticsearch >> /logs/elasticsearch_stdout.log 2>&1 &

# start up kibana
cd /local/kibana-4.0.0-BETA2
./bin/kibana 2>&1 | tee -a logs/kibana.log 

