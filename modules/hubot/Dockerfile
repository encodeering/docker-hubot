FROM           node:9.3-alpine

EXPOSE         8080

ARG            home=/home/operator
ARG            version

ENV            EXPRESS_USER=''
ENV            EXPRESS_PASSWORD=''
ENV            EXPRESS_STATIC=''
ENV            EXPRESS_PORT=8080
ENV            HUBOT_VERSION=${version}

RUN            apk --no-cache add jq expat                     \
 &&            mkdir       -p ${home} ${home}/scripts          \
 &&            adduser     -h ${home} -s /bin/bash -S hubot    \
 &&            chown -R hubot ${home}

WORKDIR        ${home}

ONBUILD ARG    modules
ONBUILD ARG    scripts='hubot-redis-brain'
ONBUILD ARG    adapter='shell'

ONBUILD ENV    HUBOT_ADAPTER=${adapter}

ONBUILD RUN    su hubot                                                                                                                  \
         &&    npm init -y                                                                                                               \
         &&    npm install --save hubot@${HUBOT_VERSION}                                                                                 \
         &&    sed -i '/"main"/d'                                                 package.json                                           \
         &&    sed -i -r 's/"test".+/"start":"hubot --adapter ${HUBOT_ADAPTER}"/' package.json                                           \
         &&    echo "${scripts} hubot-help hubot-diagnostics" | xargs -i jq -n -c -M --arg s {} '$s|split(" ")' > external-scripts.json  \
         &&    npm install --save `jq -r ".[]"                                                                    external-scripts.json` \
         &&    npm install --save "${modules}" coffee-script

ONBUILD VOLUME ${home}/scripts

ONBUILD USER   hubot

ENTRYPOINT     ["npm", "start", "--"]
