#!/bin/bash

this_directory=$(dirname "$0")
if [[ ! -f "${this_directory}/demo.cfg" ]]; then 
  echo "You must have a demo.cfg file in the same directory as this script"
  exit;
fi

source ${this_directory}/demo.cfg

echo "Resetting app ..."
# reset the app for convenience
pushd $this_directory/sample-app > /dev/null
  sed -i "" "s/GREEN/BLUE/g" static/index.html
  sed -i "" "s/env://g" manifest.yml
  sed -i "" "s/UNHAPPY: true//g" manifest.yml
  sed -i "" "/^$/d" manifest.yml # remove blank lines
popd > /dev/null

echo "Deleting apps and route..."
cf d -f unhappy-appy
cf delete-route -f $APP_DOMAIN --hostname $APP_HOSTNAME