#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION=5.6.3-SNAPSHOT
DISTDIR="$DIR/../pontus-dist/opt/pontus/pontus-elasticsearch";
TARFILE=$DIR/distribution/tar/build/distributions/elasticsearch-${VERSION}.tar.gz

CURDIR=`pwd`
cd $DIR

echo DIR is $DIR
echo TARFILE is $TARFILE

if [[ ! -f $TARFILE ]]; then
  gradle assemble
fi

if [[ ! -d $DISTDIR ]]; then
  mkdir -p $DISTDIR
fi

cd $DISTDIR
rm -rf *
tar xvfz $TARFILE
ln -s elasticsearch-$VERSION current
cd $CURDIR
