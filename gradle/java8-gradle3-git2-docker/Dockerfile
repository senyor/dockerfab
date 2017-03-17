FROM senyor/java8-gradle3-git2:latest
# Spawn not a child inside of a container, but sibling docker process in host machine
VOLUME ["/var/run/docker.sock:/var/run/docker.sock"]
RUN apk update \
    && apk add docker