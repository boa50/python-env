#!/bin/bash
docker run \
    -v $PWD/notebooks:/tf/notebooks \
    -p 8888:8888 \
    --gpus all \
    --name python-env \
    -d boa50/python-env
