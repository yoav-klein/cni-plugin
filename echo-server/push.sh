#!/bin/bash

docker build -t echo:0.1 .
docker tag echo:0.1 yoavklein3/echo:0.1
docker push yoavklein3/echo:0.1
