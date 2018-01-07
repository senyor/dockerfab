FROM haproxy:latest

RUN echo "Dir::Cache \"\";" > /etc/apt/apt.conf.d/02nocache && \
    echo "Dir::Cache::archives \"\";" >> /etc/apt/apt.conf.d/02nocache && \
    apt-get update && apt-get install rsyslog -y && \
    sed -i 's/^module(load="imklog")/#module(load="imklog")/g' /etc/rsyslog.conf && \
    sed -i 's/^#module(load="imudp")/module(load="imudp")/g' /etc/rsyslog.conf && \
    sed -i 's/^#input(type="imudp" port="514")/input(type="imudp" port="514")/g' /etc/rsyslog.conf

COPY config/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY config/rsyslog-haproxy.conf /etc/rsyslog.d/haproxy.conf
COPY docker-entrypoint.sh /

EXPOSE 80 443 1936

ENTRYPOINT ["/docker-entrypoint.sh"]