#!/bin/bash

# the 'kutt' image needs to be removed and restarted to see effects after code changes
docker rmi $(docker images | grep 'kutt-kutt') --force || docker compose -f docker-compose-dev.yml up
