#!/usr/bin/env bash

mkdir ~/.aws
cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id=$profile_access_key
aws_secret_access_key=$profile_secret_key
region=$profile_region
EOF