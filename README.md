
## Usage

```
docker create --name=phlex \
  -p 5666:80 -p 5667:443 \
  -v /configpath:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  --privileged \
  digitalhigh/phlex
```

## Parameters

By default, phlex is set to listen on ports 80(http) and 443(https). These can be changed on the docker create command by chaning it to 5666:80 and 5667:443

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 

* `-v /config` - Where phlex should store its files
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation
* `-e TZ` for timezone setting (optional), eg Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it phlex /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Find the web interface at `<your-ip>:5666`, set apps you wish to use with phlex via the webui.


## Info

* Shell access whilst the container is running: `docker exec -it phlex /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f phlex`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' phlex`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' d8ahazard/Phlex`

## Versions

+ **20.03.17:** Initial release date.
