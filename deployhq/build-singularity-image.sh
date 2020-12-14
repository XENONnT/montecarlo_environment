#!/bin/bash

# Note: this script assumes that the docker image has already been
# built and pushed

set -e

# /usr/sbin is needed for mksquashfs
export PATH=$PATH:/usr/sbin

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

rm -f xenonnt-montecarlo*.simg
singularity build xenonnt-montecarlo:${TAG}.simg docker://xenonnt/montecarlo:$TAG

echo
echo "Created simg file:"
ls -l *.simg
echo

# assuming we are running on xenon.isi.edu
mv xenonnt-montecarlo:${TAG}.simg /lizard/projects/XENONnT/xenon.isi.edu-webroot/images/.xenonnt-montecarlo:${TAG}.simg
mv /lizard/projects/XENONnT/xenon.isi.edu-webroot/images/.xenonnt-montecarlo:${TAG}.simg /lizard/projects/XENONnT/xenon.isi.edu-webroot/images/xenonnt-montecarlo:${TAG}.simg



