## Automatically created docker image for hubot

[![Build Status](https://travis-ci.org/encodeering/docker-hubot.svg?branch=master)](https://travis-ci.org/encodeering/docker-hubot)

### Docker

- https://hub.docker.com/r/encodeering/hubot-armhf/

    ```docker pull encodeering/hubot-armhf:2.19-alpine```

- https://hub.docker.com/r/encodeering/hubot-amd64/

    ```docker pull encodeering/hubot-amd64:2.19-alpine```

### Compose

```yml
version: '3'
services:
  hubot:
    image: encodeering/hubot-amd64:2.19-alpine
    ports:
      - "8080:8080"
    environment:
      - HUBOT_ADAPTER=shell             # default
      - HUBOT_SCRIPTS=hubot-redis-brain # default
      - HUBOT_MODULES=                  # default
      - REDIS_URL=redis://redis:6379/marvin
  redis:
    image: encodeering/redis-amd64:4.0-alpine
```