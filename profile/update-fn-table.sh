#!/bin/env bash

set -e


rm -f tmp.md

for image in $(jq -rc '.functions[].image' catalog.json); do
    imgShort=${image/'ghcr.io/krm-functions/'/}
    descr=$(jq -r --arg image "$image" '.functions[] | select(.image==$image) | .description' catalog.json)
    doc=$(jq -r --arg image "$image" '.functions[] | select(.image==$image) | .documentation' catalog.json)
    echo "| [$imgShort]($doc) | $descr |" >> tmp.md
done

# References
echo "| apply-replacement | See [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md), which can use setters read from other resources |" >> tmp.md

echo "| Name | Description |" > tmp2.md
echo "| --- | --- |" >> tmp2.md
cat tmp.md | sort >> tmp2.md

cp README.md tmp_README.md

# Part before table
sed '/| Name/Q' tmp_README.md > README.md
cat tmp2.md >> README.md
echo "" >> README.md
# Part after table
sed -ne '/## Verifying/,$ p' tmp_README.md >> README.md

rm tmp.md tmp_README.md
