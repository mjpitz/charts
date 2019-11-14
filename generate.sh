#!/usr/bin/env bash

readonly base_url="https://mjpitz.github.io/charts"

for chart in $(find . -iname Chart.yaml | xargs dirname | cut -c 3-); do
    destination=dist/$(dirname ${chart})
    mkdir -p ${destination}
    helm package ${chart} -d ${destination}
done

trap "rm index.yaml" EXIT

for repo in $(ls -1 dist/); do
    repo_url="${base_url}/${repo}"

    # attempt to fetch existing index.yaml
    wget -q "${repo_url}/index.yaml"
    if [[ $? -ne 0 ]]; then
        echo "apiVersion: v1" > index.yaml
    fi

    helm repo index dist/${repo} --merge index.yaml --url "${repo_url}"
done
