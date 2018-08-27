#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
VERSION=5.6.3-SNAPSHOT
DISTDIR="$DIR/../pontus-dist/opt/pontus/pontus-elasticsearch";
TARFILE=$DIR/distribution/tar/build/distributions/elasticsearch-${VERSION}.tar.gz

CURDIR=`pwd`
cd $DIR

echo DIR is $DIR
echo TARFILE is $TARFILE
echo DISTDIR is $DISTDIR

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
echo 'thread_pool.bulk.queue_size: 2000' >> conf/elasticsearch.yml
echo 'cluster.routing.allocation.disk.threshold_enabled: false' >> conf/elasticsearch.yml
cd $CURDIR
