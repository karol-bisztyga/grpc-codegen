#!/bin/bash

set -e

export PROTOC_VERSION=$(protoc --version | cut -d ' ' -f 2 2> /dev/null)
echo "current protoc version: $PROTOC_VERSION"
if [ "$PROTOC_VERSION" = "3.15.8" ]
then
  echo "required protoc version detected in the system, aborting installation"
  exit 0;
fi

echo "installing protoc..."

./check_deps.sh

echo "downloading protobuf..."
wget -P . https://github.com/protocolbuffers/protobuf/releases/download/v3.15.8/protobuf-cpp-3.15.8.tar.gz
tar xvzf protobuf-cpp-3.15.8.tar.gz
rm protobuf-cpp-3.15.8.tar.gz
mv protobuf-3.15.8 protobuf

cd protobuf

echo "configuring..."
./configure || echo "configuring failed"

echo "making..."
make
echo "make check..."
# make check
echo "installing..."
sudo make install

# we need this for to use grpc_cpp_plugin
brew install grpc

echo "protoc version should be 3.15.8"

export PROTOC_VERSION=$(protoc --version | cut -d ' ' -f 2 2> /dev/null)
echo "current protoc version: $PROTOC_VERSION"
if [ "$PROTOC_VERSION" = "3.15.8" ]
then
  echo "ALL GOOD"
  exit 0;
fi
echo "something went wrong, wrong protoc version detected... $PROTOC_VERSION"
exit 1;
