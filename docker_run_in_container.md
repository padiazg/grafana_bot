## To run the project in a container

This is intended for testing and development purpusses.  
Notice the use of *--rm* and *-it*, that means that when you leave the container everything goes away.

*--env https_proxy* is needed if you, like me, are behind a corporate proxy.

```bash
docker run -it --rm \
    -v f:/workspace/go/grafana_bot:/app \
    -p 9087:9087 \
    --env http_proxy=my_proxy:3128/ \
    --env https_proxy=my_proxy:3128/ \
    alpine \
    sh
```
Once in the container, install dependencies
```bash
apk add --no-cache ca-certificates
```

Finally to run
```bash
cd grafana_bot
./grafana_bot -t my_template.tmpl
```
