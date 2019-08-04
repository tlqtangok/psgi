#!perl
use FindBin qw($Bin);
use threads;
use feature qw(say);
use POSIX qw(assert); 
use File::Basename;

&main(); 

sub main()
{
	my $script_basename = basename $0; 

	my $script_root = $Bin; 
	say $script_root;
	my $ff = "perl $script_root/lib/ff.PL "; 

	if (@ARGV == 0)
	{
		die "- please input arg, arg num is 0 , arg should be one of { start, stop, restart }\n";
		exit(3); 
	}

	if ( @ARGV == 1 && $ARGV[0] eq "stop" || $ARGV[0] eq "restart" || $ARGV[0] eq  "start")
	{
		# wait for process	
	}
	else
	{
		die "- please input 1 arg , must be one of { start, stop, restart }\n";
		exit(1); 
	}

	if ($ARGV[0] eq "stop")
	{
		say "- to stop those process "; 
		system(qq{pgrep -al uwsgi}); 
		say ""; 
		system(qq{pgrep -al uwsgi|$ff 0|xargs kill -9}); 
		exit(0);
	}

	if ($ARGV[0] eq "restart")
	{
		system("perl $script_root/$script_basename stop");
		# then run start entry
		&run_with_arg_start(); 
		exit(0); 
	}



	if ($ARGV[0] eq "start")
	{
		&run_with_arg_start(); 
		exit (0);
	} # end start
}


sub run_with_arg_start()
{
	if (`pgrep -al uwsgi` ne "")
	{
		say "- already has process uwsgi"; 
		exit(2)	; 
	}
	my $script_root = $Bin; 
	say $script_root;

	chdir ($script_root);

	my $fn_myapp_ini = "myapp.ini"; 
	my $map_ = "perl $script_root/lib/map_.PL "; 
        my $folder_html_root = qx{cat $fn_myapp_ini | grep check-static |$map_ 's/check.static...//'};
        chomp($folder_html_root);
	`mkdir -p $folder_html_root`;
	say "- html root is $folder_html_root"; 

	my $fn_libpcre_so = "./lib/libpcre.so.1"; 
	die "- not exist $fn_libpcre_so\n"  if ! -e $fn_libpcre_so;

	threads->create(
		sub ()
		{
			if (1)
			{
				system( 
					qq{
					cd $script_root
					export LD_LIBRARY_PATH=$script_root/lib:$ENV{LD_LIBRARY_PATH}
					./uwsgi --ini myapp.ini &
					}
				); 
			}


		})->join(); 

	sleep 2; 

	my $fn_myapp_ini = "$script_root/myapp.ini";
	my $port_with_colon = qx{cat $fn_myapp_ini|grep http | $map_ 's/http...//'};
	chomp($port_with_colon); 
	die "- http server on $port_with_colon is not start, please check !\n" if (`netstat -aonp |grep $port_with_colon` eq "");

	system( qq {pgrep -al uwsgi} );
}
