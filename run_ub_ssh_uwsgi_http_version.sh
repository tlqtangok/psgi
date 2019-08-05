# for algo
# export VERSION=v2 && docker run  -dit -p 10203:22 -p 10204:10205 -v /root/jd/t/vt:/root/jd/t  --name ${VERSION}_0 -h ${VERSION}_0 ub_ssh_uwsgi_http:$VERSION

# for jd p100
export VERSION=v3 && docker run  -dit -p 10204:22 -p 10205:10205 -v /mnt/jd/t/vt:/root/jd/t  --name ${VERSION}_0 -h ${VERSION}_0 ub_ssh_uwsgi_http:$VERSION
 
# docker save it
# cd $t && export VERSION=v2 &&  time docker save -o ub_ssh_uwsgi_http_${VERSION}.tar ub_ssh_uwsgi_http:$VERSION  && time tar czf ub_ssh_uwsgi_http_$VERSION.tar.tar.gz ub_ssh_uwsgi_http_$VERSION.tar

