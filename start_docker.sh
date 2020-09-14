#!/bin/bash
docker run \
    -v $PWD:/tf/code \
    -p 8888:8888 \
    --gpus all \
    --name python_env \
    -d boa50/python-env