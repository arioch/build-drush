### Requirements

* [FPM](https://github.com/jordansissel/fpm)
* Ruby 1.8 or higher
* rpmbuild


### Usage

RHEL/CentOS:

    yum install rpm-build
    gem install fpm --no-rdoc --no-ri
    cd build
    make

Debian:

    apt-get install rpm
    gem install fpm --no-rdoc --no-ri
    cd build
    make


### Optional

* Jenkins

In order to have Jenkins to build your packages simply add a new command shell build directive, with the following content:

    make

* Vagrant

An example Vagrant project has been included to get you started right away.

    cd vagrant
    vagrant up
    make

