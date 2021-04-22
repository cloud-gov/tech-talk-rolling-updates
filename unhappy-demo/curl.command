this_directory=$(dirname "$0")
if [[ ! -f "${this_directory}/demo.cfg" ]]; then 
  echo "You must have a demo.cfg file in the same directory as this script"
  exit;
fi

source ${this_directory}/demo.cfg

app_route="${APP_HOSTNAME}.${APP_DOMAIN}"

watch -n 1 curl -s https://${app_route}