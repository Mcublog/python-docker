#!/bin/bash

docker build --build-arg SSH_PRIVATE_KEY="$(cat ks2_deploy)" -t python-test:1.0 .