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

pushd $this_directory/sample-app > /dev/null
  cf push --var route=$app_route
popd > /dev/null

open $this_directory/watch.command
open $this_directory/logs.command
open $this_directory/curl.command

source ${DEMO_MAGIC_REDUX_PATH}/demo-magic.sh 

start_demo

pushd $this_directory/sample-app > /dev/null
  sed -i "" "s/BLUE/GREEN/g" static/index.html
  echo "  env:" >> manifest.yml
  echo "    UNHAPPY: true" >> manifest.yml  
  pe "cf push --var route=${APP_HOSTNAME}.${APP_DOMAIN} --strategy rolling --no-wait"
popd > /dev/null

pe "cf cancel-deployment unhappy-appy"

wait
end_demo


