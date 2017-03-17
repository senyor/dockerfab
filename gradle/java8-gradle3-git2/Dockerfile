FROM senyor/java8:latest
ENV GRADLE_VERSION=3.4.1
ENV GRADLE_HOME=/opt/gradle-$GRADLE_VERSION
ENV PATH=$PATH:$GRADLE_HOME/bin
RUN wget http://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip -O /opt/gradle.zip \ 
    && cd /opt \ 
    && unzip gradle.zip \ 
    && rm -rf gradle.zip \
    && ln -s gradle-$GRADLE_VERSION gradle \
    && apk update \
    && apk add git
