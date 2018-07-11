To build the project in a container
```bash
 docker run -it --rm \
    -v f:/workspace/go/grafana_bot:/grafana_bot \
    --env http_proxy=http://my_proxy:3128/ \
    --env https_proxy=http://my_proxy:3128/ \
    golang:alpine \
    sh
```

Once in the container, install dependencies
```bash
apk --no-cache add make git nano curl
cd grafana_bot
go get -d -v
```

Finally to build
```bash
make clean
make
```
