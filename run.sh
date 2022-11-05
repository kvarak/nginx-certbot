#!/bin/bash

display_usage() {
	echo -e "\nUsage: $0 <build|publish>\n"
	}

if ! [ $# -eq 1 ] ; then
  display_usage
  exit 1
fi

# TODO: Check version in git history and increment
VERSION=0.0.1
PACKAGE=kvarak/nginx-certbot

if [ "$1" == "build" ] ; then
	docker build -t $PACKAGE:latest -t $PACKAGE:$VERSION .
elif [ "$1" == "push" ] ; then
	docker build -t $PACKAGE:latest -t $PACKAGE:$VERSION .
	docker push $PACKAGE:latest
  docker push $PACKAGE:$VERSION
else
  display_usage
  exit 1
fi
