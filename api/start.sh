#!/bin/sh

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
this_file=`basename $0`
this_script="$this_dir/$this_file"
user_args=$@
user_args_count=$#

echo ""
echo "-----------------------------------------------------------------------------------------------"
echo "-------  SCRIPT [$this_script $user_agrs]  -------"
echo "-----------------------------------------------------------------------------------------------"
echo ""

source ${GEM_HOME}/set_env.sh >>/dev/null

run_cmd "${GEM_API_HOME}/stop.sh" "ignore_errors"

run_cmd "${GEM_API_HOME}/build.sh" "ignore_errors"

write_log "------------------------------------------------------------------------------"
write_log "Starting GEM container [${GEM_API_CONTAINER}]..."
write_log "------------------------------------------------------------------------------"

run_cmd "docker run \
    --network ${GEM_NETWORK} \
    --hostname ${GEM_API_CONTAINER} \
    -d \
    --rm \
    -p8080:8080 \
    -p3000:3000 \
    --name ${GEM_API_CONTAINER} \
    ${GEM_API_CONTAINER}
"

write_log "------------------------------------------------------------------------------"
write_log "Sleeping for few seconds to start [${GEM_API_CONTAINER}]..."
write_log "------------------------------------------------------------------------------"

sleep 5

container_count=`docker inspect ${GEM_API_CONTAINER} | grep "running" | wc -l`
if [ $container_count -ne 1 ]; then
   write_log "Container not found [${GEM_API_CONTAINER}]"
   write_log "Failed to launch ${GEM_API_CONTAINER}"
   exit 1
else
   echo $API_MESSAGE
fi

