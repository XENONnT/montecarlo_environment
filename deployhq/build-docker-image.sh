#!/bin/bash

set -e

# git tag (if any), from DeployHQ
BRANCH=$1
TAG=$2
if [ "X$TAG" = "X" ];then
    TAG=$BRANCH
fi
if [ "X$TAG" = "Xmaster" ];then
    TAG=development
fi
echo
echo "Building for target \"$TAG\"..."
echo

# DeployHQ puts the checkout in ~/deployhq-montecarlo/
cd ~/deployhq-montecarlo/

# ensure we have the latest base image
docker pull opensciencegrid/osgvo-xenon:development

# build the Docker image (minimized)
docker build --no-cache -t xenonnt/montecarlo:$TAG .

# upload to Docker Hub - OSG will pull from there for the Singularity CVMFS repo
docker push xenonnt/montecarlo:$TAG

# development also gets mapped to "latest"
if [ "X$TAG" = "Xdevelopment" ]; then
    docker tag xenonnt/montecarlo:$TAG xenonnt/montecarlo:latest
    docker push xenonnt/montecarlo:latest
fi

