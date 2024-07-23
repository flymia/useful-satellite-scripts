#!/usr/bin/env bash

# Utilizes hammer to invoke a Ansible role run and displays the output in the terimnal in real time.
# Tested with Red Hat Satellite 6.15.1.1

if [ -z "$1" ]; then echo "Usage: ./invoke-role-run.sh <target_host|Default: none>"; exit 1; fi

JOB_ID=$(hammer job-invocation create --job-template "Ansible Roles - Ansible Default" --search-query "name = $1" --async | awk '{ print $3 }')

hammer job-invocation output --id $JOB_ID --host $1
