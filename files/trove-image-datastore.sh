#!/bin/bash

# Create Trove MySQL, MariaDB, and PostgreSQL datastores.
# Requirements:
# 1. OpenStack core and Trove services deployed using Kolla Ansible.
# 2. Sudoer user without password prompt or root.

source /etc/kolla/admin-openrc.sh

RELEASE_DATE=`curl -s https://tarballs.opendev.org/openstack/trove/images/ \
| grep trove-wallaby-guest-ubuntu-bionic.qcow2 \
| awk -F'</td>' '{print $3}' | sed -r 's/.*(.{18})/\1/' | sed -r 's/(.{10}).*/\1/'`
echo "Check the latest Trove guest image on Glance..."
openstack image list | grep trove-wallaby-guest-ubuntu-bionic-${RELEASE_DATE}
IMAGE_STATUS=$?

if [ $IMAGE_STATUS -ne 0 ]
then
  echo "The latest Trove guest image is not exist."
  echo "Remove datastore tags on other Trove guest images.."
  for U in `openstack image list | awk '/trove-wallaby-guest-ubuntu-bionic/{print $2}'`
    do
      openstack image unset --tag trove --tag mysql --tag mariadb --tag postgresql $U
    done
  echo "Downloading Trove guest image..."
  curl https://tarballs.opendev.org/openstack/trove/images/trove-wallaby-guest-ubuntu-bionic.qcow2 \
  -o trove-wallaby-guest-ubuntu-bionic-${RELEASE_DATE}.qcow2
  echo "Upload Trove guest image to Glance..."
  openstack image create trove-wallaby-guest-ubuntu-bionic-${RELEASE_DATE} \
  --private --disk-format qcow2 --container-format bare \
  --tag trove --tag mysql --tag mariadb --tag postgresql \
  --file trove-wallaby-guest-ubuntu-bionic-${RELEASE_DATE}.qcow2
  echo "Trove guest image uploaded to Glance."
else
  echo "The latest Trove guest image already exist."
fi

echo "Replace trove_guestagent_datastore_postgres_service script..."
curl -s https://raw.githubusercontent.com/utianayuba/kolla-ansible-aio-configs/wallaby-centos/files/trove_guestagent_datastore_postgres_service.py \
-o trove_guestagent_datastore_postgres_service.py
for U in `sudo find /var -name service.py | grep postgres | grep /var/lib/kolla`
do
  sudo cp trove_guestagent_datastore_postgres_service.py $U
done

echo "Replace trove_postgresql_config.template..."
curl -s https://raw.githubusercontent.com/utianayuba/kolla-ansible-aio-configs/wallaby-centos/files/trove_postgresql_config.template \
-o trove_postgresql_config.template
for U in `sudo find /var -name config.template | grep postgresql | grep /var/lib/kolla`
do
  sudo cp trove_postgresql_config.template $U
done

echo "Check and Create/Skip Trove MySQL, MariaDB, and PostgreSQL datastores..."
# Provision of MySQL still not support non-numeric version https://storyboard.openstack.org/#!/story/2009776
openstack datastore version list mysql | grep 8 > /dev/null || openstack datastore version create 8 mysql mysql "" --image-tags trove,mysql --active --default
openstack datastore version list mariadb | grep latest > /dev/null || openstack datastore version create latest mariadb mariadb "" --image-tags trove,mariadb --active --default
openstack datastore version list postgresql | grep latest > /dev/null || openstack datastore version create latest postgresql postgresql "" --image-tags trove,postgresql --active --default
openstack datastore list
openstack datastore version list mysql
openstack datastore version list mariadb
openstack datastore version list postgresql