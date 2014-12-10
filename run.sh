#!/bin/bash

exec docker run --name elktest -v `pwd`/logs:/logs -v `pwd`data:/data -p 5601:5601 -p 27018:27017 -p 9201:9200 -d anthonyserious/elktest

