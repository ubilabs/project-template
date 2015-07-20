#!/bin/bash

export APP_NAME="APP_NAME"
export SSH_HOST="user@example"
export APP_DIR="/var/www/$APP_NAME"
export BUILD_DIR="dist"

echo Deploying...

tar cfz bundle.tgz $BUILD_DIR > /dev/null 2>&1 &&
scp bundle.tgz $SSH_HOST:/tmp/ > /dev/null 2>&1 &&
rm bundle.tgz > /dev/null 2>&1 &&

ssh $SSH_HOST 'bash -s' > /dev/null 2>&1 <<ENDSSH
if [ ! -d "$APP_DIR" ]; then
  mkdir -p $APP_DIR
else
  rm -rf $APP_DIR/*
fi
pushd $APP_DIR
  tar xfz /tmp/bundle.tgz -C $APP_DIR --strip-components 1
  rm /tmp/bundle.tgz
popd
ENDSSH

echo Done.