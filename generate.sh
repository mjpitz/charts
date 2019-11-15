#!/usr/bin/env bash

readonly base_url="https://mjpitz.github.io/charts"

# start off with the current gh-pages
rm -rf dist/
git clone -q --depth 1 -b gh-pages https://github.com/mjpitz/charts.git dist

# port in any new templates
for chart in $(find . -iname Chart.yaml | xargs dirname | cut -c 3-); do
    echo "Packaging ${chart}"
    destination=dist/$(dirname ${chart})
    mkdir -p ${destination}
    helm package ${chart} -d ${destination}
done

repos=(stable)

for repo in $repos; do
    echo "Indexing ${repo}"
    repo_url="${base_url}/${repo}"

    helm repo index dist/${repo} --url "${repo_url}"
done

cp site/* dist/
