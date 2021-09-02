#!/bin/bash

set -e

export PROTOC_VERSION=$(protoc --version | cut -d ' ' -f 2)
echo "current protoc version: $PROTOC_VERSION"
if [ "$PROTOC_VERSION" = "3.15.8" ]
then
  echo "required protoc version detected in the system, aborting installation"
  exit 0;
fi

echo "installing protoc..."

./check_deps.sh

echo "setting up the repo..."
rm -rf protobuf
git clone https://github.com/protocolbuffers/protobuf.git
cd protobuf

git checkout tags/v3.15.8
git submodule update --init --recursive

echo "autogen..."
./autogen.sh || echo "autogen failed"
echo "configuring..."
./configure || echo "configuring failed"

echo "making..."
make || echo "make failed"
echo "make check..."
make check || echo "make check failed"
echo "installing..."
sudo make install || echo "make install failed"

# we need this for to use grpc_cpp_plugin
brew install grpc

echo "protoc version should be 3.15.8"

export PROTOC_VERSION=$(protoc --version | cut -d ' ' -f 2)
echo "current protoc version: $PROTOC_VERSION"
if [ "$PROTOC_VERSION" = "3.15.8" ]
then
  echo "ALL GOOD"
  exit 0;
fi
echo "something went wrong, wrong protoc version detected... $PROTOC_VERSION"
exit 1;
