## Automatically created docker image for hubot

[![Build Status](https://travis-ci.org/encodeering/docker-hubot.svg?branch=master)](https://travis-ci.org/encodeering/docker-hubot)

### Docker

- https://hub.docker.com/r/encodeering/hubot-armhf/

    ```docker pull encodeering/hubot-armhf:2.19-alpine-onbuild```

- https://hub.docker.com/r/encodeering/hubot-amd64/

    ```docker pull encodeering/hubot-amd64:2.19-alpine-onbuild```

### Compose

```Dockerfile
# Dockerfile.adapter
FROM encodeering/hubot-amd64:2.19-alpine-onbuild
```

```yml
version: '3'
services:
  hubot:
    image: encodeering/hubot-amd64:2.19-alpine-shell
    build:
      context: .
      dockerfile: Dockerfile.adapter
      args:
        adapter: shell
    ports:
      - "8080:8080"
    environment:
      - REDIS_URL=redis://redis:6379/marvin
  redis:
    image: encodeering/redis-amd64:4.0-alpine
```