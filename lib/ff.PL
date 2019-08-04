#!perl
use strict;
use Data::Dumper; 
use feature qw(say);

=pod
fetch field from txt files

*** txt.txt ***
1 2 3
4 5 6
7 8 9
-----

run :
	perl ff.PL txt.txt 1 -1
=>
1 3
4 6
7 9
-----

=cut
die "- need 2 args, perl this_file.PL filename.txt \"arr_cols\"\n" if @ARGV == 0; 


my @fc = ();
my $start_num = 1; 

#if (@ARGV > 0 && $ARGV[0] =~ m/^[-\d]/)
if ( @ARGV >= 1 && $ARGV[0] =~ m/^[\-\d]/ && ! -f $ARGV[0])
{
	@fc = <STDIN>; 
	$start_num = 0; 
}
elsif (@ARGV >= 2 && -f $ARGV[0])
{
	my $fn = @ARGV[0];
	open my $FP, "<", $fn; 
	@fc = <$FP>; 
	close $FP; 
	$start_num = 1; 
}
else
{
	die "- not invalid args\n"; 
}

@ENV{arr_cols}=join " ", @ARGV[$start_num .. @ARGV-1]; 

my @arr_col=split / /,@ENV{arr_cols};
@arr_col = grep m/\w/,@arr_col;

my @ans_all = (); 
my @t = (); 

for ( @fc ) {
	chomp;
	my @arr_fc_each = split; 

	my @ans_each=(); 
	push @ans_each , @arr_fc_each[$_] for @arr_col;
	$_= "@ans_each";    

	#say  ; 

	push @ans_all, $_; 
}

say join "\n", @ans_all; 
#say ; 


#export arr_col="0 1"  && perl -pe '@arr_col=split / /,@ENV{arr_col}; @t = split; @ans=(); push @ans , @t[$_] for @arr_col; $_= "@ans". "\n";  '  txt.txt 




