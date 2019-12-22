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
isDockerRunning true

################################################################################
printMSG "${INFO} Pulling latest flowcommerce/apibuilder-postgresql"
docker pull flowcommerce/apibuilder-postgresql
printMSG "${INFO} Squashing flowcommerce/apibuilder-postgresql before building our base container"
sudo docker-squash flowcommerce/apibuilder-postgresql &&
################################################################################


function buildCOntainer(){
    local IMAGE_HOME=${1}
    local IMAGE_TAG=${2}
    loal IMAGE_PROSE_NAME=${3}
    printMSG "${INFO} Building the ${IMAGE_PROSE_NAME}"
    cd ${BASE_IMAGE_HOME} && docker build --file Dockerfile --tag ${IMAGE_TAG} . &&
    printMSG "${INFO} Squashing our ${IMAGE_PROSE_NAME}" &&
    sudo docker-squash -t ${IMAGE_TAG} ${IMAGE_TAG}
    return ${?}
}

buildCOntainer "${BASE_IMAGE_HOME}" "${BASE_IMAGE_TAG}" "base container" &&

################################################################################
#printMSG "${INFO} Building the base container"
#cd ${BASE_IMAGE_HOME} && docker build --file Dockerfile --tag ${BASE_IMAGE_TAG} . &&
#printMSG "${INFO} Squashing our base container" &&
#sudo docker-squash -t ${BASE_IMAGE_TAG} ${BASE_IMAGE_TAG} &&
################################################################################

################################################################################
printMSG "${INFO} Building our application container" &&
cd ${APP_IMAGE_HOME} && docker build --file Dockerfile --tag ${APP_IMAGE_TAG} . &&
printMSG "${INFO} Squashing our application container" &&
sudo docker-squash -t ${APP_IMAGE_TAG} ${APP_IMAGE_TAG} &&
################################################################################

################################################################################
printFooter
################################################################################