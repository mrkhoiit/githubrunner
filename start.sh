#!/bin/bash

echo "Starting Now"

REG_TOKEN=$(curl -sX POST -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/orgs/Unstatic-co/actions/runners/registration-token | jq .token --raw-output)

echo ${REG_TOKEN}

cd /home/docker/actions-runner

./config.sh --url https://github.com/Unstatic-co --token ${REG_TOKEN}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!