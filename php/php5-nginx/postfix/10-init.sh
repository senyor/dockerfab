#!/bin/bash

# force new copy of hosts there (otherwise links could be outdated)
mkdir -p /var/spool/postfix/etc

cp -f /etc/hosts       /var/spool/postfix/etc/hosts
cp -f /etc/resolv.conf /var/spool/postfix/etc/resolv.conf
cp -f /etc/services    /var/spool/postfix/etc/services

sed -ri -e "s/^(relayhost = ).*/\1[$MAIL_HOSTNAME]:$MAIL_PORT/" \
        -e "s/^(myhostname = ).*/\1$MAIL_DOMAIN/" \
        -e "s/^(mydestination = ).*/\1localhost/" /etc/postfix/main.cf

{ \
    echo "smtp_use_tls = yes"; \
    echo "smtp_tls_CAfile = $MAIL_SERVER_CA_CERTFILE"; \
    echo "smtp_sasl_auth_enable = yes"; \
    echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd"; \
    echo "smtp_sasl_security_options = noanonymous"; \
    echo "smtp_sasl_tls_security_options = noanonymous"; \
    echo "smtp_sasl_mechanism_filter = AUTH LOGIN"; \
    echo "smtp_generic_maps = hash:/etc/postfix/generic"; \
} >> /etc/postfix/main.cf

echo "$MAIL_USERNAME@$HOSTNAME $MAIL_USERNAME@$MAIL_HOSTNAME" > /etc/postfix/generic
postmap /etc/postfix/generic

echo "[$MAIL_HOSTNAME]:$MAIL_PORT $MAIL_USERNAME@$MAIL_DOMAIN:$(cat $MAIL_PASSWORD_FILE)" >> /etc/postfix/sasl_passwd
chmod 600 /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd

# generate aliases db
newaliases || :
