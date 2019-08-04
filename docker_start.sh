#!/bin/sh

#service ssh start
date 
# export JD=JD_ENV_VAR_VALUE  # no meanings 
echo "- successfully start this container"
#bash -c "bash  /root/jd/t/ngrok/start_ngrok.sh &" &
#/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config

echo "- start http server on 10205"
/bin/bash -c 'source /root/.bashrc && echo $perl_p &&  perl /root/jd/t0/start_http_server.PL start &'

service ssh start &
/bin/bash
