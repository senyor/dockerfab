FROM senyor/java8:latest

#ARG NEXUS_VERSION=oss-thank-you-tar
ARG NEXUS_VERSION=3.2.1-01

# configure nexus runtime
ENV SONATYPE_DIR=/opt/sonatype
ENV NEXUS_HOME=${SONATYPE_DIR}/nexus \
  NEXUS_DATA=/nexus-data \
  NEXUS_CONTEXT='' \
  SONATYPE_WORK=${SONATYPE_DIR}/sonatype-work

#ENV PATH=$PATH:$GRADLE_HOME/bin

RUN apk update \
    && apk add ca-certificates wget \
    && update-ca-certificates \
    && apk add curl

# install nexus
RUN mkdir -p ${SONATYPE_DIR} \
  && cd ${SONATYPE_DIR} \
  && curl --fail --location --retry 3 --progress-bar -o nexus.tgz \
     https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz \
#     https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz \
  && tar -xvzf nexus.tgz \
  && rm -rf nexus.tgz \
  && ln -s nexus-${NEXUS_VERSION}/ nexus \
  && chown -R root:root ${NEXUS_HOME}

# configure nexus
RUN sed \
    -e '/^nexus-context/ s:$:${NEXUS_CONTEXT}:' \
    -i ${NEXUS_HOME}/etc/nexus-default.properties

RUN adduser -D -h ${NEXUS_DATA} -s /bin/false nexus \
  && mkdir -p ${NEXUS_DATA}/etc ${NEXUS_DATA}/log ${NEXUS_DATA}/tmp ${SONATYPE_WORK} \
  && ln -s ${NEXUS_DATA} ${SONATYPE_WORK}/nexus3 \
  && chown -R nexus:nexus ${SONATYPE_DIR}

VOLUME ${NEXUS_DATA}

EXPOSE 8081
USER nexus
WORKDIR ${NEXUS_HOME}/

ENV JAVA_MAX_MEM=1200m \
  JAVA_MIN_MEM=1200m \
  EXTRA_JAVA_OPTS=""

CMD ["bin/nexus", "run"]





