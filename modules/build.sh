#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/node-$ARCH:9.3-alpine" "node:9.3-alpine"

docker-build -f "$PROJECT/Dockerfile" --build-arg version="$PIN" "$PROJECT"

docker-verify -v