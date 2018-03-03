#!/usr/bin/env bash

mkdir ~/.aws
cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id=$PROFILE_ACCESS_KEY_ID
aws_secret_access_key=$PROFILE_SECRET_ACCESS_KEY
region=$profile_region
EOF