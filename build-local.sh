#!/bin/bash
export PATH=/root/work/thirdparty/gradle.4.9/bin:$PATH
export JAVA_HOME=/root/work/pontus-git/pontus-elasticsearch/jdk-10.0.2
export RUNTIME_JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64
DIR="$( cd "$(dirname "$0")" ; pwd -P )"
VERSION=6.4.0-SNAPSHOT
#VERSION=5.6.3-SNAPSHOT
DISTDIR="$DIR/../pontus-dist/opt/pontus/pontus-elasticsearch";
TARFILE=$DIR/distribution/archives/tar/build/distributions/elasticsearch-${VERSION}.tar.gz
CURDIR=`pwd`
cd $DIR

echo DIR is $DIR
echo TARFILE is $TARFILE
echo DISTDIR is $DISTDIR

if [[ ! -f $TARFILE ]]; then
  $DIR/gradlew assemble
fi

if [[ ! -d $DISTDIR ]]; then
  mkdir -p $DISTDIR
fi

cd $DISTDIR
rm -rf *
tar xvfz $TARFILE
ln -s elasticsearch-$VERSION current
echo 'thread_pool.bulk.queue_size: 2000' >> current/config/elasticsearch.yml
echo 'cluster.routing.allocation.disk.threshold_enabled: false' >> current/config/elasticsearch.yml
cd $CURDIR

echo cd $DISTDIR
