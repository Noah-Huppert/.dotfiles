#!/usr/bin/env bash
TAG="noahhuppert/neovim:latest"
docker build -t "$TAG" --build-arg USER="$USER" .
