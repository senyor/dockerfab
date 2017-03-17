FROM senyor/java8-gradle3-git2:latest
RUN apk update \
    && apk add openrc \ 
    && apk add docker \
    && rc-update add docker boot 
