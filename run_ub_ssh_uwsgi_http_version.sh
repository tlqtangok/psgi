# for algo
# export VERSION=v2 && docker run  -dit -p 10203:22 -p 10204:10205 -v /root/jd/t/vt:/root/jd/t  --name ${VERSION}_0 -h ${VERSION}_0 ub_ssh_uwsgi_http:$VERSION

# for jd p100
export VERSION=v2 && docker run  -dit -p 10204:22 -p 10205:10205 -v /mnt/jd/t/vt:/root/jd/t  --name ${VERSION}_0 -h ${VERSION}_0 ub_ssh_uwsgi_http:$VERSION
