use strict;
use diagnostics;
use warnings;
use Getopt::Std;
use Tie::File;
use vars qw($opt_r);
use vars qw($opt_a);
getopts('ra');

tie my @file_lines , 'Tie::File', '/Users/mat/@@files/p/p.txt' or die "$!";

if ( $opt_a ){
my $email_address = pop @ARGV;
my $person = join ' ' , @ARGV;
push @file_lines , "$person:$email_address";
@file_lines = sort @file_lines;
print "Added $person\n";
}
elsif( $opt_r ){
if(@ARGV == 0){
print "Nothing to Delete\n";
}
else{
@file_lines = grep !/$ARGV[0]/ , @file_lines;
print "Removed $ARGV[0]\n";
}
}
else{
if (@ARGV == 0){
print join ("\n" , @file_lines);
print "\n";
}
else{
my @results = grep /$ARGV[0]/ , @file_lines;
print join ("\n" , @results);
print "\n";
my @email_address = split ':', $results[0];
open (TO_CLIPBOARD, "|pbcopy");
print TO_CLIPBOARD $email_address[1];
}
}
untie @file_lines;
