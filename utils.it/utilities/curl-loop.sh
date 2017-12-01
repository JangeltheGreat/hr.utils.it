#!/bin/bash
variables.sh

while true
do
	curl -IL $1
	sleep 5
done