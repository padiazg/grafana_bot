## To run the project as a daemon

Intended for production environments.  
We map with *-v* the template and configuration files, then pass them as parameters to container **ENTRYPOINT** with *-t {template}* and *-c {config_file}*

*--env https_proxy=....* and *--build-arg  https_proxy=...* is needed if you, like me, are behind a corporate proxy.

Build the image
```bash
docker build \
    -t padiazg/grafana-bot \
    --build-arg http_proxy=http://10.118.1.80:3128/ \
    --build-arg https_proxy=http://10.118.1.80:3128/ \
    .
```

Run a container
```bash
docker run -d \
    -v f:\workspace\go\grafana_bot\my_template.tmpl:/my_template.tmpl \
    -v f:\workspace\go\grafana_bot\config.yaml:/config.yaml \
    --env https_proxy=http://my_proxy:3128/ \
    -p 9087:9087 \
    --name grafana-bot \
    padiazg/grafana-bot \
    -t /my_template.tmpl \
    -c /config.yaml
```
