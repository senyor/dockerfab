FROM senyor/java8:latest
ENV ARTIFACTORY_VERSION=5.1.3
ENV ARTIFACTORY_HOME=/opt/artifactory
ENV PATH=$PATH:$ARTIFACTORY_HOME/bin
RUN apk update \ 
    && apk add ca-certificates wget \ 
    && update-ca-certificates \ 
    && wget https://bintray.com/jfrog/artifactory/download_file?file_path=jfrog-artifactory-oss-$ARTIFACTORY_VERSION.zip -O /opt/artifactory.zip \ 
    && cd /opt \ 
    && unzip artifactory.zip \ 
    && rm -rf artifactory.zip \
    && ln -s artifactory-oss-$ARTIFACTORY_VERSION artifactory
