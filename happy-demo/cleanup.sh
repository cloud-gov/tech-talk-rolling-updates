#!/bin/bash

this_directory=$(dirname "$0")
if [[ ! -f "${this_directory}/demo.cfg" ]]; then 
  echo "You must have a demo.cfg file in the same directory as this script"
  exit;
fi

source ${this_directory}/demo.cfg

echo "Resetting app colors..."
# reset the app for convenience
pushd $this_directory/sample-app > /dev/null
  sed -i "" "s/d2ff8f/bddcff/g" index.html
  sed -i "" "s/green/blue/g" index.html
popd > /dev/null

echo "Deleting apps and route..."
cf d -f my-app
cf d -f my-app-new
cf delete-route -f $APP_DOMAIN --hostname $APP_HOSTNAME