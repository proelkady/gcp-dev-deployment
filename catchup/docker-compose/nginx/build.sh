#!/bin/bash

# Build and push nginx image script
# Usage: ./build.sh <version>
# Example: ./build.sh 0.1.15

set -e

if [ -z "$1" ]; then
    echo "Error: Version number required"
    echo "Usage: ./build-and-push.sh <version>"
    echo "Example: ./build-and-push.sh 0.1.15"
    exit 1
fi

VERSION=$1
IMAGE_NAME="proelkady/catchup-nginx"
FULL_TAG="${IMAGE_NAME}:${VERSION}"

echo "Building image: ${FULL_TAG}"
docker build -t "${FULL_TAG}" .

echo "Pushing image: ${FULL_TAG}"
docker push "${FULL_TAG}"

echo "Successfully built and pushed ${FULL_TAG}"
