# ./uwsgi --ini myapp.ini
curl  -i --header "Content-Type: application/json"  -X POST -d @json.json 'localhost:10205/cgi-bin/do_post.cgi?POST_QUERY=V&POST_QUERY_0=V0'
#curl  -i --header "Content-Type: application/json"  -X POST -d @json.json '172.16.29.4:10205/cgi-bin/do_post.cgi?POST_QUERY=V&POST_QUERY_0=V0'
curl  -i 'localhost:10205/cgi-bin/do_get.cgi?GET_QUERY=V&GET_QUERY_0=V0'
#curl  -i '172.16.29.4:10205/cgi-bin/do_get.cgi?GET_QUERY=V&GET_QUERY_0=V0'

