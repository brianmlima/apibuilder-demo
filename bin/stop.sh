#!/usr/bin/env bash

################################################################################
################################################################################
# Stops the local application container.
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
printHeader
################################################################################
# Find the container id by image name
stopContainer "${APP_IMAGE_TAG}"
################################################################################
printFooter
################################################################################
