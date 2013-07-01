#!/bin/sh -e

# Change to "yes" to do a full update/upgrade every 7 days:
UPGRADE_EVERYTHING=no
if [] "$UPGRADE_EVERYTHING" = "yes" ]
then
  LAST_APT_UPDATE=/etc/vagrant_last_apt_update
  LAST_UPDATE_SECONDS=999999999
  # 1 week:
  APT_UPDATE_SECONDS=$((7 * 24 * 60 * 60))
  if [ -f "$LAST_APT_UPDATE" ]
  then
    LAST_UPDATE_SECONDS=$(($(date +%s) - $(stat -c %Y "$LAST_APT_UPDATE")))
    echo "Last apt-get update was $(($LAST_UPDATE_SECONDS / 24 / 60 / 60)) days ago"
  else
    echo "No apt-get last update file found (will update)"
  fi

  if [ "$LAST_UPDATE_SECONDS" -gt "$APT_UPDATE_SECONDS" ]
  then
    echo "Updating all packages";
    # Update to latest and greatest:
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get upgrade -y
    touch "$LAST_APT_UPDATE"
  else
    echo "Skipping apt-get update/upgrade";
  fi
fi

IS_APP_PROVISIONED="/etc/vagrant_provisioned_at"
if [ ! -f "$IS_APP_PROVISIONED" ]
then
  apt-get update

  # Execute the custom setup script:
  . /mnt/bootstrap/install.sh

  # Mark the VM as provisioned:
  touch "$IS_APP_PROVISIONED"
else
  echo "Skipping setup (already done)"
fi
