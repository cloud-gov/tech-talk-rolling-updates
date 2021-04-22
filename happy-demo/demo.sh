#!/bin/bash 

set -e

this_directory=$(dirname "$0")
if [[ ! -f "${this_directory}/demo.cfg" ]]; then 
  echo "You must have a demo.cfg file in the same directory as this script"
  exit;
fi

source ${this_directory}/demo.cfg

# Set up

echo "Setting up for the demo"

app_route="${APP_HOSTNAME}.${APP_DOMAIN}"

open $this_directory/watch.command

pushd $this_directory/sample-app
  cf push my-app --var route=$app_route
popd

source ${DEMO_MAGIC_REDUX_PATH}/demo-magic.sh 

start_demo

pe "cf apps"

wait # open in a browser
open "https://${app_route}"

pushd $this_directory/sample-app > /dev/null
  sed -i "" "s/bddcff/d2ff8f/g" index.html
  sed -i "" "s/blue/green/g" index.html
  pe "cf push my-app-new --var route=${APP_HOSTNAME}.${APP_DOMAIN}"
popd > /dev/null

wait # open in a browser
open "https://${app_route}"

pe "cf app --guid my-app"
pei "cf app --guid my-app-new"

pe "cf delete -f my-app-new"

pe "cf scale -i 10 my-app"

pe "cf push --help"

pushd $this_directory/sample-app > /dev/null
  pe "cf push my-app --strategy rolling --var route=${APP_HOSTNAME}.${APP_DOMAIN} -i 10"
popd > /dev/null

open "https://${app_route}"

wait
end_demo