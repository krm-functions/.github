#!/bin/env bash

set -e

for image in $(jq -rc '.functions[].image' catalog.json); do
    digest=$(jq -r --arg image "$image" '.functions[] | select(.image==$image) | .digest' catalog.json)
    builder=$(jq -r --arg image "$image" '.functions[] | select(.image==$image) | .builder' catalog.json)

    cosign verify --certificate-identity $builder@refs/heads/main --certificate-oidc-issuer https://token.actions.githubusercontent.com $image@$digest 2>&1 | head -n6
done
