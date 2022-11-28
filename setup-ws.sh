#!/usr/bin/env bash

# Start minikube
minikube start

# Save IP to a hostname
echo "`minikube ip` docker.local" | sudo tee -a /etc/hosts > /dev/null
