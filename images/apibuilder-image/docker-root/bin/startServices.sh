#!/usr/bin/env bash
################################################################################
## Resolves the directory this script is in. Tolerates symlinks.
SOURCE="${BASH_SOURCE[0]}" ;
while [[ -h "$SOURCE" ]] ; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "${SOURCE}")"
  if [[ $SOURCE == /* ]]; then
    SOURCE="${TARGET}"
  else
    DIR="$( dirname "${SOURCE}" )"
    SOURCE="${DIR}/${TARGET}" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
BASE_DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )" ;
################################################################################
source ${BASE_DIR}/Functions.sh
source ${BASE_DIR}/conf.sh

printMSG "Starting Postgres"
su postgres --command '/usr/lib/postgresql/10/bin/postgres -i -D /var/lib/postgresql/10/main' &
printMSG "Starting API, There may show some ignorable errors as services start."
${API_DIST_START_CMD} &
printMSG "Starting APP, There may show some ignorable errors as services start."
${APP_DIST_START_CMD} &
tail -f /dev/null
