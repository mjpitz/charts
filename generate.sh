#!/usr/bin/env bash

# start off with the current gh-pages
rm -rf dist/
git clone -q --depth 1 -b gh-pages https://github.com/mjpitz/charts.git dist
mkdir -p dist/

# port in any new charts
for chart in $(find . -iname Chart.yaml | xargs dirname | cut -c 3-); do
    echo "Packaging ${chart}"
    helm package ${chart} -d dist/
done

# index
helm repo index dist/ --url "https://mjpitz.github.io/charts"
cp README.md dist/
