# Example requests
curl -v http://0.0.0.0:9292/readings/1

curl -H "Content-Type: application/json" -X POST -d '{"sensor_id": "1","readings": [{"timestamp": "2017-08-31T18:04:00Z", "value": 111.0}, {"timestamp": "2017-08-31T18:05:00Z", "value": 222.0}, {"timestamp": "2017-08-31T18:06:00Z", "value": 333.0}]}' http://0.0.0.0:9292/readings


## Development

Using [Docker](https://www.docker.com/what-docker)

You can build the image with:

```
docker build -t api .
docker-compose build
docker-compose up
```
