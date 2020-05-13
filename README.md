## speedtest-cli-influx

Small docker container build for arm that uses speedtest-cli and posts the results to influxdb on a set interval.


Inspired on https://github.com/pedrocesar-ti/internet-speedtest-docker but with different parsing and influx api v2 POST.

Used resources:
* https://www.speedtest.net/apps/cli
* https://www.mankier.com/1/speedtest-cli
* https://github.com/pedrocesar-ti/internet-speedtest-docker/tree/master/speedtest


### Build locally
You can build the docker container locally but take note of the cpu architecture you are building it on.

Run the following on a Pi or other architecture:
```
docker build -t deetoreu/speedtest-cli-influx:latest .
```

## Deployment
The docker container is available on Docker Hub: https://hub.docker.com/r/deetoreu/speedtest-cli-influx

### Environment variables
These variables can be passed to the image from kubernetes.yaml or docker-compose.yml as needed:

Variable | Default | Description |
-------- | ------- | ----------- |
TEST_INTERVAL |  | The test interval, according the [sleep](http://man7.org/linux/man-pages/man1/sleep.1.html) number convention
DB_HOST |  | Address of your influx instance
DB_NAME |  | The influx database in which you want to store the results

### Docker
docker run example:
```
docker run -e TEST_INTERVAL=5m -e DB_HOST="http://192.168.1.100:8086" -e DB_NAME=speedtest deetoreu/speedtest-cli-influx:latest
```
or add the detach `-d` flag to run in the background

docker-compose.yml example:
```yaml
version: '3.6'
services:
  speedtest:
    container_name: speedtest
    image: deetoreu/speedtest-cli-influx:latest
    network_mode: host
    environment:
      TEST_INTERVAL: "5m"
      DB_HOST: "192.168.1.100:8086"
      DB_NAME: "speedtest"
```

I noticed some speed limitation which disappeared when `network_mode` was set to `host`
