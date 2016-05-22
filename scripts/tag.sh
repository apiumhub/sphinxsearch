#!/usr/bin/env bash

source version.properties

version=$IMAGE_VERSION

git tag -a v$version -m "released new version"