#!/usr/bin/env bash

set -e

echo "${HUBOT_SCRIPTS} hubot-help hubot-diagnostics" \
   | xargs -i jq -n -c -M --arg s {} '$s|split(" ")' > external-scripts.json

npm install `jq -r ".[]"                               external-scripts.json`
npm install "hubot-${HUBOT_ADAPTER}" "${HUBOT_MODULES}"

exec npm start -- --adapter "${HUBOT_ADAPTER}" "$@"
