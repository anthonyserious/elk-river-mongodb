#!/bin/bash

# If we were given arguments, run them instead
if [ $? -gt 1 ]; then
  exec "$@"
fi

PREFIX=/local
MONGO_HOME=$PREFIX/mongodb-linux-x86_64-2.6.5
ES_HOME=$PREFIX/elasticsearch-1.4.0
KIBANA_HOME=$PREFIX/kibana-4.0.0-BETA2

# Start up mongod
[ ! -d /data/mongodb ] && mkdir /data/mongodb
$MONGO_HOME/bin/mongod --config $MONGO_HOME/mongod.conf --fork

# This would be....kludgy.  Initiate replica set in case it hasn't already been.
sleep 2
ip=$( grep `hostname` /etc/hosts|cut -f1 )
tmpConfig=`mktemp`
cat > $tmpConfig <<EOF
config = {
   "_id" : "rs0",
   "version" : 1,
   "members" : [
      {
         "_id" : 1,
         "host" : "$ip:27017"
      }
   ]
}
rs.reconfig(config, {force:true})
rs.initiate()
EOF

$MONGO_HOME/bin/mongo < $tmpConfig
rm -f $tmpConfig

# start up elasticsearch
[ ! -d /data/elasticsearch ] && mkdir /data/elasticsearch
$ES_HOME/bin/elasticsearch -d

# start up kibana.  Keep logging to stdout to keep the container up and running.
$KIBANA_HOME/bin/kibana 2>&1 | tee -a logs/kibana.log


