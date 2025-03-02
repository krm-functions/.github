#!/bin/env bash

set -e
# Provide catalog files to merge as argument

jq -s '.[0].functions=([.[].functions]|flatten)|.[0]' "${@:1}" > catalog.json
