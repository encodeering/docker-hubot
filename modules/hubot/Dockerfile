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
 &&            mkdir   -p ${home}                              \
 &&            adduser -h ${home} -s /bin/bash -S hubot        \
 &&            npm install -g coffee-script yo generator-hubot

WORKDIR        ${home}

USER           hubot

ONBUILD ARG    name
ONBUILD ARG    description
ONBUILD ARG    owner
ONBUILD ARG    modules
ONBUILD ARG    scripts='hubot-redis-brain'
ONBUILD ARG    adapter='shell'

ONBUILD ENV    HUBOT_ADAPTER=${adapter}

ONBUILD RUN    yo hubot --owner="${owner}" --name="${name}" --description="${description}" --adapter="${adapter}" --defaults             \
         &&    npm   install --save hubot@${HUBOT_VERSION}                                                                               \
         &&    npm uninstall --save `jq -r ".[]"                                                                  external-scripts.json` \
         &&    echo "${scripts} hubot-help hubot-diagnostics" | xargs -i jq -n -c -M --arg s {} '$s|split(" ")' > external-scripts.json  \
         &&    npm   install --save `jq -r ".[]"                                                                  external-scripts.json` \
         &&    npm   install --save "${modules}" coffee-script                                                                           \
         &&    rm hubot-scripts.json README.md scripts/*

ONBUILD VOLUME ${home}/scripts

ENTRYPOINT     ["/bin/bash", "-c", "bin/hubot", "-a", "${HUBOT_ADAPTER}"]
