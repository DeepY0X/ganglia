#!/bin/bash

# Download ganglia from
# Url: http://ganglia.info
#
# Unpack in /usr/src
# sudo tar zxvf ganglia-3.6.0.tar.gz -C /usr/local/
# cd /usr/src
# sudo ln -s ganglia-3.6.0/ ganglia
# cd /usr/src/ganglia

id_user=`id -u`

if [ $id_user -ne 0 ];
then
  echo "You are not allowed to execute this script." && exit 1
fi

# Install dependencies and dev packages for Ubuntu or *.deb based Linux distributions
apt-get install libapr1-dev libconfuse-dev libexpat1-dev pkg-config python-dev libpcre3-dev rrdtool build-essential librrd-dev

# Install dependencies and dev packages for Redhat or *.rpm based Linux distributions
#yum install libconfuse-devel.x86_64 pcre pcre-devel apr-devel apr libconfuse expat expat-devel pkgconfig python-devel rrdtool rrdtool-devel
# For gmond and gmetad
./configure --prefix=/usr/local/ganglia --with-gmetad

# Only for gmond
#./configure --prefix=/usr/local/ganglia

# Build ganglia
make
make install

# Create directories and change permissions
mkdir -p /var/lib/ganglia/rrds
useradd ganglia
chown -R ganglia /var/lib/ganglia/rrds/
mkdir -p /var/lib/ganglia-web/conf
chown www-data /var/lib/ganglia-web/conf/ -R
mkdir /var/lib/ganglia-web/dwoo/compiled -p
chown www-data /var/lib/ganglia-web/dwoo/compiled/ -R
mkdir /var/lib/ganglia-web/dwoo/cache
chown www-data /var/lib/ganglia-web/dwoo/cache/ -R

