#!/bin/sh
STUNNEL_CONF=/etc/stunnel/stunnel.conf
STUNNEL_BINARY=/usr/bin/stunnel

rm -f $STUNNEL_CONF

#echo "setuid = stunnel" >> $STUNNEL_CONF
#echo "setgid = stunnel" >> $STUNNEL_CONF
echo "pid = /run/stunnel/stunnel.pid" >> $STUNNEL_CONF
echo "foreground = yes" >> $STUNNEL_CONF

IMAP_DST_PORT=${IMAP_DST_PORT:=993}
POP3_DST_PORT=${POP3_DST_PORT:=995}
SMTP_DST_PORT=${SMTP_DST_PORT:=465}

if [ $DEBUG_ON ]; then
    echo "debug = 7" >> $STUNNEL_CONF
    echo "output = /dev/stdout" >> $STUNNEL_CONF
fi

if [ $IMAP_DST_HOST ]; then
    echo "[email imap]" >> $STUNNEL_CONF
    echo "client = yes" >> $STUNNEL_CONF
    echo "connect = ${IMAP_DST_HOST}:${IMAP_DST_PORT}" >> $STUNNEL_CONF
    echo "accept = ${HOSTNAME}:143" >> $STUNNEL_CONF
    echo "verifyChain = yes" >> $STUNNEL_CONF
    echo "CApath = /etc/ssl/certs" >> $STUNNEL_CONF
    echo "CAfile = /etc/ssl/certs/ca-certificates.crt" >> $STUNNEL_CONF
    echo "checkHost = ${IMAP_DST_HOST}" >> $STUNNEL_CONF
    echo "OCSPaia = yes" >> $STUNNEL_CONF
fi

if [ $POP3_DST_HOST ]; then
    echo "[email pop3]" >> $STUNNEL_CONF
    echo "client = yes" >> $STUNNEL_CONF
    echo "connect = ${POP3_DST_HOST}:${POP3_DST_PORT}" >> $STUNNEL_CONF
    echo "accept = ${HOSTNAME}:110" >> $STUNNEL_CONF
    echo "verifyChain = yes" >> $STUNNEL_CONF
    echo "CApath = /etc/ssl/certs" >> $STUNNEL_CONF
    echo "CAfile = /etc/ssl/certs/ca-certificates.crt" >> $STUNNEL_CONF
    echo "checkHost = ${POP3_DST_HOST}" >> $STUNNEL_CONF
    echo "OCSPaia = yes" >> $STUNNEL_CONF
fi

echo "[email smtp]" >> $STUNNEL_CONF
echo "client = yes" >> $STUNNEL_CONF
echo "connect = ${SMTP_DST_HOST}:${SMTP_DST_PORT}" >> $STUNNEL_CONF
echo "accept = ${HOSTNAME}:25" >> $STUNNEL_CONF
echo "verifyChain = yes" >> $STUNNEL_CONF
echo "CApath = /etc/ssl/certs" >> $STUNNEL_CONF
echo "CAfile = /etc/ssl/certs/ca-certificates.crt" >> $STUNNEL_CONF
echo "checkHost = ${SMTP_DST_HOST}" >> $STUNNEL_CONF
echo "OCSPaia = yes" >> $STUNNEL_CONF

$STUNNEL_BINARY
