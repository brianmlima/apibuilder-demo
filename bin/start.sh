#!/usr/bin/env bash
################################################################################
################################################################################
# Runs the docker container for Api-Builder. This has the GUI APP, API service,
# And the latest generators from apibuilder.io.
#
################################################################################
################################################################################

################################################################################
## Resolves the directory this script is in. Tolerates symlinks.
SOURCE="${BASH_SOURCE[0]}" ;
while [[ -h "$SOURCE" ]] ; do TARGET="$(readlink "${SOURCE}")"; if [[ $SOURCE == /* ]]; then SOURCE="${TARGET}"; else DIR="$( dirname "${SOURCE}" )"; SOURCE="${DIR}/${TARGET}"; fi; done
BASE_DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )" ;
PROJECT_HOME="$( cd -P "${BASE_DIR}/../" && pwd )"
################################################################################
source ${PROJECT_HOME}/bin/Functions.sh
source ${PROJECT_HOME}/bin/conf.sh
################################################################################

################################################################################

GLOBAL_TIMER=`timer`
################################################################################
printHeader
################################################################################
printMSG "Using local share at ${LOCAL_SHARE_PATH} for logs and example files"
docker run ${DOCKER_RUN_PORT_OPTIONS} ${APP_IMAGE_TAG}
################################################################################
printFooter
################################################################################
