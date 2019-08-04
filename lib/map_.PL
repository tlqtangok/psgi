#!perl


use Data::Dumper; 
use POSIX qw(assert); 



my @argv = ( @ARGV );
my $templ_ = q{ 
	cat __FILELIST__ | perl -e '@arr=<>;map{__MAPSTATEMENT__;print ; }@arr;'
}; 

if (@argv == 0 || @argv > 2 ){
	print "- please run by:\n\t";
	print "map_ txt.txt 's/abc/ABC/;'\n" ; 
	print "ls | map_ 's/abc/ABC/;'\n" ; 
	
	print $templ_; 
	exit (1); 
}

if (@argv >= 2)
{

	my $__MAPSTATEMENT__ = @argv[-1]; 
	assert($argv[-1] =~ m/^s/); 

	@argv[-1] = ""; 

	my $__FILELIST__ = "@argv"; 


	$templ_ =~ s/__FILELIST__/$__FILELIST__/; 
	$templ_ =~ s/__MAPSTATEMENT__/$__MAPSTATEMENT__/; 

=pod
print '- run:',"\n";
print '===================', ""; 
print $templ_ ; 
print '===================', "\n\n"; 
=cut

	system(  $templ_ ); 
}
elsif (@argv == 1)
{
	assert($argv[0] =~ m/^s/); 
	my $tmp_file = '/tmp/txt.txt'; 

	open $FP, ">", $tmp_file or die; 
	my @fc_ = <STDIN>; 
	my $fc = join "", @fc_; 
	print $FP $fc; 
	close $FP; 

	my $__MAPSTATEMENT__ = @argv[-1]; 
	assert($argv[-1] =~ m/^s/); 

	my $__FILELIST__ = "$tmp_file"; 

	$templ_ =~ s/__FILELIST__/$__FILELIST__/; 
	$templ_ =~ s/__MAPSTATEMENT__/$__MAPSTATEMENT__/; 

	system(  $templ_ ); 
}
else
{
	die "- error argv\n" ; 
}

#print "EOF\n";

