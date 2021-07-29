#!/bin/env bash

if [ -z "$1" ]; then
	echo "Subcommands:"
	echo "get {Version} {Build}"
	echo "listVersions"
	echo "listBuilds {Version}"
fi

if [ "$1" = "get" ]; then
	if [ -z "$3" ]; then
		echo "Usage:"
		echo "papermc get {Version} {Build}"
		echo "Version is the minecraft version in the format 1.17.1 or 1.17"
		echo "Build is the papermc build to use."
		echo "You can also pass in 'latest' into any of the parameters."
	else
		mcver=$2
		build=$3

		if [ "$mcver" = "latest" ]; then
			mcver="$(curl -X GET "https://papermc.io/api/v2/projects/paper" -H "accept: application/json" | jq -r ".versions[-1]")"
		fi
		if [ "$build" = "latest" ]; then
			build="$(curl -X GET "https://papermc.io/api/v2/projects/paper/versions/$mcver" -H "accept: application/json" | jq ".builds[-1]")"
		fi

		download="$(curl -X GET "https://papermc.io/api/v2/projects/paper/versions/$mcver/builds/$build" -H "accept: application/json" | jq -r ".downloads.application.name")"

		curl -X GET "https://papermc.io/api/v2/projects/paper/versions/$mcver/builds/$build/downloads/$download" -H "accept: application/java-archive" -o paperclip.jar

	fi
fi

if [ "$1" = "listVersions" ]; then
	curl -X GET "https://papermc.io/api/v2/projects/paper" -H "accept: application/json" | jq -r ".versions | .[]"
fi
if [ "$1" = "listBuilds" ]; then
	if [ -z "$2" ]; then
		echo "Usage:"
		echo "papermc listBuilds {Version}"
		echo "Version is the minecraft version in the format 1.17.1 or 1.17"
	else
		mcver=$2
		curl -X GET "https://papermc.io/api/v2/projects/paper/versions/$mcver" -H "accept: application/json" | jq ".builds | .[]"
	fi
fi

# curl -X GET "https://papermc.io/api/v2/projects/paper/versions/1.17.1" -H "accept: application/json" | jq ".builds[-1]"
