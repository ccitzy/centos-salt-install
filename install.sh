#!/usr/bin/env bash

TOP_DIR=$(cd $(dirname "$0") && pwd)
cd $TOP_DIR

yum -y install gcc gcc-c++ python-devel python-setuptools m2crypto pkgconfig

cd $TOP_DIR/rpms
rpm -hiv openpgm-5.1.118-3.el6.x86_64.rpm
rpm -hiv zeromq3-3.2.3-1.el6.x86_64.rpm
rpm -hiv zeromq3-devel-3.2.3-1.el6.x86_64.rpm

cd $TOP_DIR/pips
pip --version >/dev/null 2>&1 || (
    tar -xzf pip-1.4.tar.gz &&
    cd pip-1.4 &&
    python setup.py install &&
    cd $TOP_DIR &&
    rm -fr pip-1.4 )

pip install MarkupSafe-0.18.tar.gz PyYAML-3.10.zip \
    pycrypto-2.6.tar.gz msgpack-python-0.3.0.tar.gz \
    pyzmq-13.1.0.zip Jinja2-2.7.tar.gz salt-0.16.2.tar.gz

cd $TOP_DIR
[ -d /etc/salt ] || cp -r conf /etc/salt
cp -n init/salt-* /etc/rc.d/init.d/