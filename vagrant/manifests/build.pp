exec {
  'repo update':
    command => '/usr/bin/apt-get update';
}

Package {
  require => Exec['repo update'],
}

package {
  'make': ensure => present;
  'rpm':  ensure => present;
  'vim':  ensure => present;
}

package {
  'fpm':
    ensure   => latest,
    provider => gem;
}

# -*- mode: ruby -*-
# vi: set ft=ruby :
