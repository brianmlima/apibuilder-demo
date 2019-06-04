########################################################################################################################
# Build on the demo base we just built
FROM brianmlima/apibuilder-demo-base
########################################################################################################################
# add in the local docker root
ADD docker-root /opt/app
WORKDIR /opt/app
########################################################################################################################
# We are only running system installs here so lets run as root
USER root
########################################################################################################################
# Environment for clone/build/exec
ENV SYSTEMS_ROOT /opt/demo
ENV SERVICE_ROOT ${SYSTEMS_ROOT}/services
ENV PROJECTS_ROOT ${SYSTEMS_ROOT}/projects

########################################################################################################################
# ENV for setting up the eventual services from the build.
ENV APIBUILDER_PROJECT_ROOT="${PROJECTS_ROOT}/apibuilder"
########################################################################################################################
# App Stuffs
ENV APP_PROJECT_ROOT="${APIBUILDER_PROJECT_ROOT}"
ENV APP_APP_NAME="apibuilder-app"
ENV APP_DIST_ARTIFACT_NAME="${APP_APP_NAME}-0.1.0-SNAPSHOT.zip"
ENV APP_DIST_ARTIFACT_PATH="${APP_PROJECT_ROOT}/app/target/universal/${APP_DIST_ARTIFACT_NAME}"
ENV APP_DIST_DIR_PATH="${SERVICE_ROOT}/${APP_APP_NAME}"
ENV APP_DIST_START_CMD="${APP_DIST_DIR_PATH}/bin/${APP_APP_NAME}"
########################################################################################################################
# API Stuffs
ENV API_PROJECT_ROOT="${APIBUILDER_PROJECT_ROOT}"
ENV API_APP_NAME="apibuilder-api"
ENV API_DIST_ARTIFACT_NAME="${API_APP_NAME}-0.1.0-SNAPSHOT.zip"
ENV API_DIST_ARTIFACT_PATH="${API_PROJECT_ROOT}/api/target/universal/${API_DIST_ARTIFACT_NAME}"
ENV API_DIST_DIR_PATH="${SERVICE_ROOT}/${API_APP_NAME}"
ENV API_DIST_START_CMD="${API_DIST_DIR_PATH}/bin/${API_APP_NAME} -Dhttp.port=9001"



ENV CLEAN_AFTER_APT_GET rm -rf /var/lib/apt/lists/*
ENV APT_GET_OPTIONS -y --no-install-recommends
ENV APT_GET apt-get ${APT_GET_OPTIONS}
ENV INSTALL ${APT_GET} install
ENV REMOVE ${APT_GET} --allow-remove-essential purge
ENV UPDATE ${APT_GET} update
ENV CLEAN ${APT_GET} clean

ENV REMOVE_PACKAGES sbt unzip git default-jdk-headless git-man liberror-perl libperl5.22 openjdk-8-jdk-headless perl  perl-modules-5.22




########################################################################################################################
# BUILD!
RUN mkdir -p ${SERVICE_ROOT} ${PROJECTS_ROOT} \
    && git clone 'https://github.com/apicollective/apibuilder.git' ${PROJECTS_ROOT}/apibuilder \
    && bash -xc "export SBT_OPTS='-XX:+CMSClassUnloadingEnabled -XX:MaxMetaspaceSize=2G -Xmx4G' && pushd ${PROJECTS_ROOT}/apibuilder > /dev/null &&  sbt --error dist && popd > /dev/null" \
    && bash -xc "unzip ${APP_DIST_ARTIFACT_PATH} -d ${SERVICE_ROOT} && mv ${SERVICE_ROOT}/${APP_DIST_ARTIFACT_NAME%.zip} ${SERVICE_ROOT}/${APP_APP_NAME}" \
    && bash -xc "unzip ${API_DIST_ARTIFACT_PATH} -d ${SERVICE_ROOT} && mv ${SERVICE_ROOT}/${API_DIST_ARTIFACT_NAME%.zip} ${SERVICE_ROOT}/${API_APP_NAME}" \
    && rm -rf ${PROJECTS_ROOT} \
    && ${REMOVE} ${REMOVE_PACKAGES} \
    && ${INSTALL} default-jre-headless \
    && apt autoremove \
    && ${CLEAN_AFTER_APT_GET}

########################################################################################################################
# Ports for DB, API, and APP
EXPOSE 5432/tcp
EXPOSE 9000/tcp
EXPOSE 9001/tcp

########################################################################################################################
# Starts DB, API, and APP
ENTRYPOINT /opt/app/bin/startServices.sh

