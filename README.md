# psgi
a perl web framework, with a docker container

## usage
for docker, just copy this folder to /root/jd/psgi , and 
copy docker_start.sh to /start.sh


## to run 
the best way is to use docker image, to run that image : `sh run_ub_ssh_uwsgi_http_version.sh`

perl $ROOT/start_http_server.PL start

## to stop 
perl $ROOT/start_http_server.PL stop

## to restart
perl $ROOT/start_http_server.PL restart 


## log file 
$ROOT/run_log.log


