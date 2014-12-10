# Elasticsearch + Kibana 4 + MongoDB River Plugin
Single image containing ELK stack with Kibana 4 Beta 2, plus the [MongoDB River plugin](https://github.com/richardwilly98/elasticsearch-river-mongodb).  It is useful for testing out the whole stack in a single container.

This stack matches the MongoDB River plugin's requirements:
  1. MongoDB River plugin 2.0.4
  2. Elasticsearch 1.4.0
  3. MongoDB 2.6.5

To run, you will want to map the /logs and /data volumes:

```bash
docker run --name elkmongo -v `pwd`/logs:/logs -v `pwd`/data:/data \
  -p 5601:5601 -p 27017:27017 -p 9200:9200 \
  -d anthonyserious/elk-river-mongodb
```
