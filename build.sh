#!/bin/bash

## Script:  build.sh
## Version: 0.0.1
## Author:  Tom De Vylder <tomdv@inuits.eu>
## Contrib: 

set -e

rm -rf *.rpm
if [ ! -d tmp ]; then mkdir tmp; fi

for DRUSH in $(grep -viE '^#|^$' build.txt | awk {'print $1'} | sort | uniq )
do
  DRUSH_URL="http://ftp.drupal.org/files/projects/${DRUSH}.tar.gz"
  DRUPAL_VERSION=$(echo ${DRUSH} | cut -d '-' -f 2 | cut -d '.' -f 1)
  DRUSH_VERSION=$(echo ${DRUSH} | cut -d '-' -f 3 | sed -e 's/.tar.gz//g')
  DRUSH_NAME_RHEL=$(echo drupal${DRUPAL_VERSION}-drush)
  
  echo -e "\e[1;34m[\e[00m --- \e[00;32mBuild package: ${DRUSH}\e[00m --- \e[1;34m]\e[00m"
  if [ ! -f tmp/${DRUSH}.tar.gz ]; then wget -P tmp/ ${DRUSH_URL}; fi
  if [ -d tmp/drush ]; then rm -rf tmp/drush; fi
  tar xzf tmp/${DRUSH}.tar.gz -C tmp/
  chmod 751 tmp/drush/drush

  fpm -s dir -t rpm --architecture noarch \
    --name ${DRUSH_NAME_RHEL} \
    --version ${DRUSH_VERSION} \
    --url 'http://drupal.org/project/drush' \
    -C tmp/ \
    --iteration 999 \
    --license 'GPLv2' \
    --description 'Drush is a command line shell and scripting interface for Drupal.' \
    --prefix '/usr/local' \
    drush

  if [ -d tmp/drush ]; then rm -rf tmp/drush; fi
  echo
done

