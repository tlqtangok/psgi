#!/bin/sh

#service ssh start
date 
# export JD=JD_ENV_VAR_VALUE  # no meanings 
echo "- successfully start this container"
#bash -c "bash  /root/jd/t/ngrok/start_ngrok.sh &" &
#/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config

echo "- start http server on 10205"
perl /root/jd/t0/start_http_server.PL start &
echo "- end http server"

echo "- start ssh server "
service ssh start &
echo "- end ssh server "

echo "- start bash daemon ..."
/bin/bash
