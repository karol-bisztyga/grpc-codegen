#!/bin/bash

# example usage: ./generate.sh xxx.proto out

if [ $# -ne 2 ]
then
  echo "please provide 2 args: input file and output dir"
  exit 1;
fi

export DIR=$(dirname $1)

protoc -I=$DIR --cpp_out=$2 --grpc_out=$2 --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` $1

echo "ALL GOOD"
