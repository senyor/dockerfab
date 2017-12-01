FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    apt-get remove docker && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd dockercoreos -g 233 && usermod -a -G docker,dockercoreos jenkins && \
    curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose && \
    chmod +x /usr/bin/docker-compose

#    systemctl enable docker.service && \
# systemctl enable jenkins.service && \
# sed -i 's#ExecStart=/usr/bin/dockerd -H fd://#ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375#g' /lib/systemd/system/docker.service && \
# sed -i 's#DOCKER_OPTS=#DOCKER_OPTS="-H tcp://0.0.0.0:2375"#g' /etc/init.d/docker && \

#ENTRYPOINT ["/lib/systemd/systemd"]

#CMD [""]
#CMD ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]

