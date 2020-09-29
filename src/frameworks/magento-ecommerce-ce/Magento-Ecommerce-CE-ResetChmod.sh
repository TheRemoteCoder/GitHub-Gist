#!/bin/sh

# Repair or restore Magento shop CHMOD settings.
# There are some custom files and issue fixes incorporated.
#
# Tested with Magento CE 1.5.1.0 - 1.6.1.0.
# Run this script with 'chmod o+x' applied.


# -------------------------------------------------------------------------------------------------------------- Select folder, Startup info

WD=`dirname "$0"`; # Working directory

cd $WD;
clear
ls -al;

echo -n "
==================================================
Globally change all Magento web CHMOD settings
==================================================
find . -type f -exec chmod 0644 {} \;
find . -type d -exec chmod 0755 {} \;
chmod o+w app/etc var var/.htaccess;
chmod o+w var/backups var/cache var/connect;
chmod o+w var/export var/log var/session var/report;
chmod o+w var/minifycache;
chmod -R o+w media;
chmod -R o+w share;
chmod 0550 lib/PEAR
chmod 0745 cron.sh;
chmod 0745 cron.php;
chmod 0600 app/etc/local.xml;
chmod o+x mage;
==================================================

Continue? [y,N]";
read answer;


# -------------------------------------------------------------------------------------------------------------------------------------- Run

if [ "$answer" = "y" -o "$answer" = "Y" ]
then
  find . -type f -exec chmod 0644 {} \;
  find . -type d -exec chmod 0755 {} \;
  chmod o+w app/etc var var/.htaccess;
  chmod o+w var/backups var/cache var/connect;
  chmod o+w var/export var/log var/session var/report;
  chmod o+w var/minifycache;
  chmod -R o+w media;
  chmod -R o+w share;
  chmod 0550 lib/PEAR
  chmod 0745 cron.sh;
  chmod 0745 cron.php;
  chmod 0600 app/etc/local.xml;
  chmod o+x mage;
fi

ls -al;
