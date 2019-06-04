#!/usr/bin/env bash


################################################################################
# Editable configuration.
################################################################################

ORG_NAME="testOrg"
ORG_KEY="${ORG_NAME}"
ORG_VISIBILITY="organization"
ORG_NAMESPACE="org.test"

################################################################################
# Add or remove any generators you want added during setup. NOTE these must be
# running when the setup script is executed.
declare -a GENERATORS=(
"https://generator.apibuilder.io"
"https://apibuilder-js-generator.flow.io"
"https://kd8pxibtlj.execute-api.us-east-1.amazonaws.com/Prod"
"https://nk1os5d7vg.execute-api.us-east-1.amazonaws.com/Prod"
"https://fq7ggcnkad.execute-api.eu-west-1.amazonaws.com/dev"
);

################################################################################
# DO NOT EDIT START.
################################################################################
################################################################################
# Image Stuffs
BASE_IMAGE_TAG="brianmlima/apibuilder-demo-base:latest"
APP_IMAGE_TAG="brianmlima/apibuilder-demo-app:latest"
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







