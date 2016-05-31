#!/usr/bin/env bash
indexer --rotate --all "$@"
searchd --nodetach "$@"
