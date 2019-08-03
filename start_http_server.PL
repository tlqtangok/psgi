#!perl
use FindBin qw($Bin);
use threads;
use feature qw(say);
use POSIX qw(assert); 

&main(); 

sub main()
{
	my $script_root = $Bin; 
	say $script_root;

	chdir ($script_root);
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
	my $map_ = "perl $ENV{perl_p}/map_.PL "; 
	my $port_with_colon = qx{cat $fn_myapp_ini|grep http | $map_ 's/http...//'};
	die "- http server on $port_with_colon is not start, please check !\n" if (`netstat -aonp |grep $port_with_colon` eq "");
}
