#!/usr/bin/env bash
################################################################################
################################################################################
# Build and local install the base and application docker images
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

isCommandInstalled docker true

isCommandInstalled docker-squash true

docker pull flowcommerce/apibuilder-postgresql

sudo docker-squash flowcommerce/apibuilder-postgresql &&

printMSG "Building the base container"
#${BASE_IMAGE_BUILD_CMD} &&
################################################################################
cd ${BASE_IMAGE_HOME} && docker build --file Dockerfile --tag ${BASE_IMAGE_TAG} . &&
sudo docker-squash -t ${BASE_IMAGE_TAG} ${BASE_IMAGE_TAG} &&

################################################################################
printMSG "Building the application container" &&
################################################################################
cd ${APP_IMAGE_HOME} && docker build --file Dockerfile --tag ${APP_IMAGE_TAG} . &&
sudo docker-squash -t ${APP_IMAGE_TAG} ${APP_IMAGE_TAG} &&


################################################################################

#${APP_IMAGE_BUILD_CMD}
################################################################################
printFooter
################################################################################
