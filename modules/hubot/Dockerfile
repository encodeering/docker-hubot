FROM           node:9.3-alpine

EXPOSE         8080

ARG            home=/home/operator
ARG            version

ENV            EXPRESS_USER=''
ENV            EXPRESS_PASSWORD=''
ENV            EXPRESS_STATIC=''
ENV            EXPRESS_PORT=8080
ENV            HUBOT_VERSION=${version}

RUN            apk --no-cache add jq expat                        \
 &&            mkdir       -p ${home} ${home}/scripts ${home}/bin \
 &&            adduser     -h ${home} -s /bin/bash -S hubot

WORKDIR        ${home}

COPY           bin bin

ONBUILD ARG    modules
ONBUILD ARG    scripts='hubot-redis-brain'
ONBUILD ARG    adapter='shell'

ONBUILD ENV    HUBOT_ADAPTER=${adapter}
ONBUILD ENV    HUBOT_SCRIPTS=${scripts}
ONBUILD ENV    HUBOT_MODULES=${modules}

ONBUILD RUN    su hubot                                                                                                                  \
         &&    npm init -y                                                                                                               \
         &&    npm install --save hubot@${HUBOT_VERSION} coffee-script                                                                   \
         &&    sed -i '/"main"/d'                                                 package.json                                           \
         &&    sed -i -r 's/"test".+/"start":"hubot"/'                            package.json                                           \
         &&    chown -R hubot:nogroup .                                                                                                  \
         &&    chmod -R +x bin

ONBUILD VOLUME ${home}/scripts

ONBUILD USER   hubot

ENTRYPOINT     ["bin/docker-entrypoint.sh"]
