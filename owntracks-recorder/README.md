# Dockerfile for OwnTracks Recorder with MySQL Storage

This is a Dockerfile for the [OwnTracks Recorder](https://github.com/owntracks/recorder). 
It is loosely based on the official [OwnTracks Recorder Dockerfile](https://github.com/owntracks/recorderd) 
but does not include a dedicated MQTT server. Instead, it includes Lua hooks for an additional MySQL 
storage back end and stores location data in a table called `location` somewhat compatible with that used 
by the old "m2s" daemon.

## Using the image

```sh
$ docker run --name my-recorder -v /var/lib/owntracks/data:/owntracks -d cgraefe/owntracks-recorder
```

```sh
$ docker run --name my-recorder \ 
  -v /var/lib/owntracks/data:/owntracks \
  -e ORT_HOST=mqtt.my-servers.com \
  -e MYSQL_HOST=mysql.my-servers.com \
  -e MYSQL_DB=owntracks \
  -e MYSQL_USER=dbuser \
  -e MYSQL_PASSWORD=thisissecret \
  -d cgraefe/owntracks-recorder
```
