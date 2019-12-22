#!/usr/bin/env bash


################################################################################
# Editable configuration.
################################################################################

ORG_NAME="bml"
ORG_KEY="${ORG_NAME}"
ORG_VISIBILITY="organization"
ORG_NAMESPACE="org.bml"

################################################################################
# Add or remove any generators you want added during setup. NOTE these must be
# running when the setup script is executed.
declare -a GENERATORS=(
 "https://generator.apibuilder.io"
 "http://docker.for.mac.localhost:9002"
 "https://apibuilder-js-generator.flow.io"
);

################################################################################
# DO NOT EDIT START.
################################################################################
################################################################################
# Image Stuffs

FROM_VERSION="latest"
BASE_IMAGE_TAG="brianmlima/apibuilder-demo-base:${FROM_VERSION}"
APP_IMAGE_TAG="brianmlima/apibuilder-demo-app:${FROM_VERSION}"
IMAGES_PATH="${PROJECT_HOME}/images"
BASE_IMAGE_HOME="${IMAGES_PATH}/base-image"
BASE_IMAGE_BUILD_CMD="${BASE_IMAGE_HOME}/bin/build.sh"
APP_IMAGE_HOME="${IMAGES_PATH}/apibuilder-image"
APP_IMAGE_BUILD_CMD="${APP_IMAGE_HOME}/bin/build.sh"
################################################################################
################################################################################
################################################################################
APP_CONTAINER_PORT="9000" ;
API_CONTAINER_PORT="9001" ;
################################################################################
# These can not change, the dev setup expects these ports in the container.
# If changed the app may not function.
APP_HOST_PORT="9000" ;
API_HOST_PORT="9001" ;
################################################################################
DOCKER_PORT_OPTIONS="-p ${APP_HOST_PORT}:${APP_CONTAINER_PORT} -p ${API_HOST_PORT}:${API_CONTAINER_PORT}"
################################################################################
################################################################################
# DO NOT EDIT STOP.
################################################################################







