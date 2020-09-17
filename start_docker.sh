#!/bin/bash
docker run \
    -v $PWD/notebooks:/tf/notebooks \
    -p 8888:8888 \
    --gpus all \
    -u 1000:1000 \
    -e DISPLAY \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/shadow:/etc/shadow:ro \
    -v /etc/sudoers.d:/etc/sudoers.d:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --name python-env \
    -d boa50/python-env
