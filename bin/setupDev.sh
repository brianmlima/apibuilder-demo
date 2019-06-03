#!/usr/bin/env bash
################################################################################
################################################################################
# Uses the web interface to setup an organization, API token, and adds the
# default generators to the local API Builder App.
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

WGET_SERVER_RESPONSE=false
WGET_QUITE=true
WGET_OUTPUT=false

WGET_ARGS=""
[[ ${WGET_SERVER_RESPONSE} = true ]] && WGET_ARGS="--server-response"
[[ ${WGET_QUITE} = true ]] && WGET_ARGS="${WGET_ARGS} --quiet"
[[ ${WGET_OUTPUT} = true ]] && WGET_ARGS="${WGET_ARGS} -O -" || OUTPUT=" -O /dev/null"

LOGIN_PATH="/login/dev"
APP_HOST="http://localhost:${APP_HOST_PORT}" ;
API_HOST="http://localhost:${API_HOST_PORT}" ;
COOKIE_FILE="/tmp/api-builder-setup-cookies.txt"

CREATE_ORG_POST_DATA="name=${ORG_NAME}&key=${ORG_KEY}&visibility=${ORG_VISIBILITY}&namespace=${ORG_NAMESPACE}" ;

################################################################################
################################################################################

function baseFetch() {
    wget ${WGET_ARGS} --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 ${@}
}
function baseFetchRetry500() {
    baseFetch --retry-on-http-error=500 ${@}
}
function fetch() {
    baseFetch --load-cookies ${COOKIE_FILE} ${@}
}
function fetchCredentials() {
    baseFetchRetry500 --save-cookies ${COOKIE_FILE} --keep-session-cookies --delete-after ${@}
}

function addGenerator(){
    local _APP_HOST=${1}
    local _GENERATOR_HOST=${2}
    local _ADD_GENERATOR_POST_DATA="uri=$(urlencode "${_GENERATOR_HOST}" )" ;
    printMSG "Adding the generators at ${_ADD_GENERATOR_POST_DATA} "
    fetch --post-data="${_ADD_GENERATOR_POST_DATA}" ${_APP_HOST}/generators/createPost
}

function createToken(){
    local GET_TOKEN_PATH=`fetch --post-data="description=Dev" -O - ${APP_HOST}/tokens/postCreate | grep -o '/tokens/cleartext/[^"]*'` ;
    echo $(fetch ${APP_HOST}${GET_TOKEN_PATH} -O - | sed -e 's/ //g' | grep -Eo '^[A-Za-z0-9]{80,80}$')
}

################################################################################
printHeader
################################################################################

################################################################################
# Make sure the COOKIE_FILE does not already exist.
rm -f ${COOKIE_FILE}

################################################################################
# Try and log in and save the cookies so we can make more calls
printMSG "Getting dev login for apibuilder app. This may retry as the server starts.";
fetchCredentials ${APP_HOST}${LOGIN_PATH}
checkStatus ${?} "Dev Login Success" "Dev Login Failed. Cowardly exiting" ;
################################################################################
# Check to make sure the organization does not already exist.
fetch ${APP_HOST}/${ORG_NAME}

STATUS=${?}
if [[ ${STATUS} = 0 ]]; then
    printMSG "Organization ${ORG_NAME} already exists. Attempting update."
    fetch --post-data="${CREATE_ORG_POST_DATA}" "${APP_HOST}/org/editPost?org_key=${ORG_KEY}"
    checkStatus ${?} "Organization ${ORG_NAME} Update success" "Failed to update ${ORG_NAME} organization. Cowardly exiting" ;
else
    printMSG "Organization ${ORG_NAME} does not yet exist. Attempting create"
    fetch  --post-data="${CREATE_ORG_POST_DATA}" ${APP_HOST}/org/createPost
    checkStatus ${?} "Organization ${ORG_NAME} creation success" "Failed to create  ${ORG_NAME} organization. Cowardly exiting" ;
fi

################################################################################
# Add Generators from config.
for generator_host in ${GENERATORS[@]} ; do
    addGenerator "${APP_HOST}" "${generator_host}"
done

# Create a token and echo it so we can use it.
TOKEN=`createToken`
printMSG "Created Dev API Token ${TOKEN}"

################################################################################
# Output an example configuration file
CONFIG_EXAMPLE_ROOT="${SHARE_ROOT}/apibuilder"
mkdir -p "${CONFIG_EXAMPLE_ROOT}"
printMSG "Writing dev apibuilder-cli localhost configuration. This should be placed in your ~/.apibuilder/config file"
echo "[profile localhost]
api_uri = ${API_HOST}
token = ${TOKEN} "

################################################################################
printFooter
################################################################################
