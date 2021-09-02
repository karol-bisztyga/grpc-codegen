#!/bin/bash

#!/bin/bash

set -e

echo "checking dependencies..."

for LIB in autoconf automake libtool curl make g++ unzip wget
do
  export PRESENT=1
  echo -n "$LIB "
  which $LIB > /dev/null 2> /dev/null || export PRESENT=0
  if [ $PRESENT -eq 0 ]
  then
    brew list $LIB > /dev/null 2> /dev/null || export PRESENT=0
  fi
  if [ $PRESENT -eq 0 ]
  then
    echo "not found, adding..."
    brew install $LIB
  else
    echo "OK"
  fi
done

echo "ALL GOOD"