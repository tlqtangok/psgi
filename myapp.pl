#!perl
#use strict; 
use feature qw(say); 
use Data::Dumper; 
use File::Basename qw(dirname basename);
use Cwd qw(abs_path cwd);



my $app = sub() 
{
    # main_
    my $env = shift;
    say `pwd`;
    my $req = &parse_req_from_env($env);
    say Dumper($req); 

    my $fc = &routine_not_file($env->{PATH_INFO}); # 'PATH_INFO' => '/cgi-bin/xxx.cgi'

    my $ret_str =<<END
    $fc
END
;	

    return [
        '200',
        [ 'Content-Type' => 'text/html' ],    # ["Content-Type' => 'text/plain'],
        [ $ret_str ],
    ];

};


### sub list ### 
sub routine_not_file($path_rel)
{
	my $path_rel = shift;
	my $ret_str = ""; 
	my $map_ = "perl $ENV{perl_p}/map_.PL "; 
	my $fn_myapp_ini = "myapp.ini"; 
	my $folder_html_root = qx{cat $fn_myapp_ini | grep check-static |$map_ 's/check.static...//'}; 
	chomp($folder_html_root);

	my @module_name = qw(
	tmi.cgi
	tmi2.cgi
	); 

	#my $curdir = cwd(); 

	#say $curdir. $path_rel; 	
	#say `ls -thl ${curdir}${path_rel}`;

	if (-d "$folder_html_root$path_rel") # show dir content 
	{
		my $fc = `ls -thl $folder_html_root$path_rel`;
		$ret_str = "<html><pre>$fc</pre></html>"; 
=pod
my $ret_str =<<END
<html><head><link href="/favicon.ico"></head><body><h1>Hello World</h1>
<pre>
$fc
</pre>
</body></html>

END
;	
=cut

	}
	else # not file, not dir, just a router, run router logic
	{
		# tmi.cgi
		# tm2.cgi

		$ret_str = "- into my script , params: [$path_rel]";	

		my $e_router =  substr($path_rel,1);

		if ($e_router ~~ @module_name)
		{
			my $router_cgi_out = `perl cgi-bin/$e_router | grep -v Content-Type`;
			$ret_str = $router_cgi_out; 
		}
	}

    return $ret_str;
}

sub parse_req_from_env($env)
{
=pod	
test set:
    curl  -i --header "Content-Type: application/json"  -X POST -d @json.json '172.16.29.4:10205/cgi-bin/xxx.cgi?POST_QUERY=V&POST_QUERY_0=V_0'
    curl  -i '172.16.29.4:10205/cgi-bin/xxx.cgi?GET_QUERY=V&GET_QUERY_0=V_0'
=cut
    my $env = shift;

    my $req = {
        REQUEST_METHOD => $env->{REQUEST_METHOD},
        PATH_INFO => $env->{PATH_INFO},
        QUERY_STRING => $env->{QUERY_STRING},
        POST_CONTENT => "NULL CONTENT", 
    };

    if ($req->{REQUEST_METHOD} eq "POST")
    {
        my $cl = $env->{CONTENT_LENGTH};
        $env->{'psgi.input'}->seek(0,0);
	$req->{POST_CONTENT} = "";
        while ($cl) 
        {
            $env->{'psgi.input'}->read(my $chunk, $cl < 8192 ? $cl : 8192);
            my $read = length $chunk;
            $cl -= $read;
            $req->{POST_CONTENT} .= $chunk;
        }
    }


=pod
    #say "- you $req->{REQUEST_METHOD} from $req->{PATH_INFO}\?$req->{QUERY_STRING}";
    #say ", has POST content is [$req->{POST_CONTENT}] " if $req->{POST_CONTENT} ne "NULL CONTENT"; 

    if(0)
    {
        my $uwsgi_opt = uwsgi::opt;
        say ""; 
        say Dumper($uwsgi_opt);  # somthing about ini
        say ""; 
    }
=cut

    return $req; 
}
### sub end ###
