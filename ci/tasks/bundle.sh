#!/bin/sh
set -e

echo "Installing zip"
apk update
apk add zip

export CURRENT_VERSION="$(cat metadata/version)"
export REVISION="$(cat metadata/revision)"

# Bundle up the output
mkdir staging

echo "Staging files from the source"
cp cloud-service-broker/CHANGELOG.md staging/
cp cloud-service-broker/OSDF*.txt staging/

echo "Staging files from metadata"
cp metadata/version staging/
cp -r metadata/docs staging/

echo "Staging server binaries"
mkdir -p staging/servers
cp tiles/* staging/servers

echo "Staging client binaries"
mkdir -p staging/clients
cp client-darwin/* staging/clients
cp client-linux/* staging/clients
cp client-windows/* staging/clients

echo "Creating release"
zip bundle/cloud-service-broker-$CURRENT_VERSION-$REVISION.zip -r staging/*
