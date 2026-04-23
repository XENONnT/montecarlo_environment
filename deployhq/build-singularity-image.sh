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

IMAGE_FILE="xenonnt-montecarlo:${TAG}.simg"
singularity build "${IMAGE_FILE}" "docker://xenonnt/montecarlo:${TAG}"

echo
echo "Created simg file:"
ls -l *.simg
echo

if [ ! -f "${IMAGE_FILE}" ]; then
    echo "ERROR: Expected image file not found: ${IMAGE_FILE}" >&2
    exit 1
fi

# Publish (assuming we are running on xenon.isi.edu)
PUBLISH_DIR="/scitech/shared/projects/XENONnT/xenon.isi.edu-webroot/images"
if [ -d "${PUBLISH_DIR}" ]; then
    mv -f "${IMAGE_FILE}" "${PUBLISH_DIR}/.${IMAGE_FILE}"
    mv -f "${PUBLISH_DIR}/.${IMAGE_FILE}" "${PUBLISH_DIR}/${IMAGE_FILE}"
else
    echo "WARNING: Publish directory not found (${PUBLISH_DIR}); skipping publish step."
fi


