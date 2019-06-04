ARG FROM_VERSION
FROM flowcommerce/apibuilder-postgresql:${FROM_VERSION:-latest}
########################################################################################################################
# We are only running system installs here so lets run as root
USER root

ENV CLEAN_AFTER_APT_GET rm -rf /var/lib/apt/lists/*
ENV APT_GET_OPTIONS -y --no-install-recommends
ENV APT_GET apt-get ${APT_GET_OPTIONS}
ENV INSTALL ${APT_GET} install
ENV REMOVE ${APT_GET} --allow-remove-essential purge
ENV UPDATE ${APT_GET} update
ENV CLEAN ${APT_GET} clean

ENV REMOVE_PACKAGES pkg-config apt-utils libgnutls-dev apt-transport-https mlocate zip build-essential libapt-inst2.0 vim

########################################################################################################################
# Update and install in this order so we dont get odd warnings and errors due to install order.
RUN ${UPDATE} \
    && ${INSTALL} apt-utils apt-transport-https unzip git \
    && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
    && ${UPDATE} \
    && ${INSTALL} default-jdk-headless sbt \
    && ${REMOVE} ${REMOVE_PACKAGES} \
    && ${CLEAN} && ${CLEAN_AFTER_APT_GET}

########################################################################################################################
#Build the latest wget so we can use retry on error code. Really time for ubuntu to fix their old apt-get version
#RUN bash -xc "pushd /tmp && curl https://ftp.gnu.org/gnu/wget/wget-1.20.3.tar.gz | tar -xzv && pushd wget-1.20.3/ && ./configure && make install && popd && popd && rm -rf wget-1.20.3 ;"

########################################################################################################################
#Get the known versions of scala we need into the docker cache for faster build in later stages while iterating
#RUN echo 'crossScalaVersions := Seq("2.12.7", "2.10.6", "2.11.7")' > build.sbt \
#    && echo 'object Hi { def main(args: Array[String]) = println("Done") }' > src.scala \
#    && sbt "+run" \
#    && rm build.sbt src.scala