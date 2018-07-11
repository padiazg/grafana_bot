To run the project in a container, for testing and delopment purpusses
```bash
docker run -it --rm \
    -v f:/workspace/go/prometheus_bot:/app -p 9087:9087 \
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
./grafana_bot -t vision.tmpl
```
