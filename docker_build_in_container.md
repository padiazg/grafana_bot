## To build the project in a container

This is intended for development purpusses.  
Notice the use of *--rm* and *-it*, that means that when you leave the container everything goes away.

*--env https_proxy* is needed if you, like me, are behind a corporate proxy.

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
