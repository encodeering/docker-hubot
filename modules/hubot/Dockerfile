FROM           node:9.3-alpine

EXPOSE         8080

ARG            home=/home/operator
ARG            version
ARG            modules
ARG            adapter='shell'
ARG            scripts='hubot-redis-brain'

ENV            HUBOT_ADAPTER=${adapter}
ENV            HUBOT_SCRIPTS=${scripts}
ENV            HUBOT_MODULES=${modules}

ENV            EXPRESS_USER=''
ENV            EXPRESS_PASSWORD=''
ENV            EXPRESS_STATIC=''
ENV            EXPRESS_PORT=8080

RUN            apk --no-cache add jq expat                        \
 &&            mkdir       -p ${home} ${home}/scripts ${home}/bin \
 &&            adduser     -h ${home} -s /bin/bash -S hubot

WORKDIR        ${home}

COPY           bin bin

RUN         su hubot                                             \
 &&         npm init -y                                          \
 &&         npm install --save hubot@${version} coffee-script    \
 &&         sed -i '/"main"/d'                      package.json \
 &&         sed -i -r 's/"test".+/"start":"hubot"/' package.json \
 &&         chown -R hubot:nogroup .                             \
 &&         chmod -R +x bin

VOLUME      ${home}/scripts

USER        hubot

ENTRYPOINT     ["bin/docker-entrypoint.sh"]
