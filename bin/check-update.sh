#!/usr/bin/env bash

# Script to check if there are updates available. If so, the $adminemail get's an email.

# set -x

_adminemail="admin@example.com"

# Unlock packages via foreman
foreman-maintain packages unlock > /dev/null 2>&1

# Check updates
dnf -q check-update > /dev/null 2>&1

case $? in
        0)
                echo "No updates available!"
                ;;
        130)
                echo "There are updates available!" | mail -s "Satellite Updates available" $_adminemail
                ;;
        100)
                echo "There are updates available!" | mail -s "Satellite Updates available" $_adminemail
                ;;
        *)
                echo "Error while reading out updates for the Satellite Server." | mail -s "Satellite Updates: Error while checking" $_adminemail
                ;;
esac

# Lock packages again
foreman-maintain packages lock > /dev/null 2>&1

exit 0
