# version of uwsgi : 2.0.18
# export VERSION=v0 && docker run  -dit -p 10204:22 -p 10205:10205 -v /mnt/jd/t/ana:/mnt/jd/t/ana -v /mnt/jd/t/vt:/root/jd/t  --name ${VERSION}_5 -h ${VERSION}_5 ub_ssh_uwsgi_http:$VERSION
# sudo ln -s /lib/x86_64-linux-gnu/libpcre.so.3.13.2 /lib/x86_64-linux-gnu/libpcre.so.1
# sudo apt install g++
# sudo apt install make 

# bld 
sudo apt install libperl-dev
sudo cpan -i Plack::Util  Devel::StackTrace
curl http://uwsgi.it/install | bash -s psgi `pwd`/uwsgi

# run
# export LD_LIBRARY_PATH=`pwd`/lib:$LD_LIBRARY_PATH 
# ./uwsgi --ini myapp.pl

# or just use start_http_server.PL
# perl start_http_server.PL  start


#bld_uwsgi.sh
#cgi-bin
#favicon.ico
#json.json
#myapp.ini
#myapp.pl
#run_log.log
#test.sh
#uwsgi
#uwsgi_latest_from_installer/
#uwsgi_latest_from_installer.tar.gz
