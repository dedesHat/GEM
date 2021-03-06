#!/bin/sh

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
this_file=`basename $0`
this_script="$this_dir/$this_file"
user_args=$@
user_args_count=$#

echo ""
echo "-----------------------------------------------------------------------------------------------"
echo "-------  Executing [$this_script $user_agrs]  -------"
echo "-----------------------------------------------------------------------------------------------"
echo ""

source ${GEM_HOME}/set_env.sh >>/dev/null

cd ${GEM_API_HOME}
write_log "Present Working Directory : ${PWD}"

run_cmd "${GEM_API_HOME}/stop.sh" "ignore_errors"

write_log "------------------------------------------------------------------------------"
write_log "Building docker image ... "
write_log "------------------------------------------------------------------------------"
run_cmd "docker build -t ${GEM_API_CONTAINER} -f Dockerfile ."

write_log "SUCCESS"
