#!/usr/bin/env bash

cat <<EOF > backend.conf
key="feedyard-$1-profiles/auth.tfstate"
bucket="feedyard-$1-state"
region="$2"
profile="default"
EOF