export VERSION=v0 && docker run  -dit -p 10203:22 -p 10204:10205 -v /root/jd/t/vt:/root/jd/t  --name ${VERSION}_0 -h ${VERSION}_0 ub_ssh_uwsgi_http:$VERSION
