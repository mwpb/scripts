# A script that displays and interacts with the folder it is in.
#
# Directions:
#
# Put in a folder and create a subdirectory call .archive
# Use no flag to search the list e.g.:
# perl .edit_items.pl search_term1 search_term2
# this returns the intersection
#
# Use the -a flag to add items.
# to add an event write something like
# perl .edit_items.pl -a 2015-11-10 this is an event
# to add a task something like
# perl .edit_items.pl -a this is a task
# to add a name include capitals; to add an email use the '@' symbol
# perl .edit_items.pl -a John Smith john@smith.com
#
# To remove an entry use the -r tag
# use empty search to determine number
# perl .edit_items.pl -r 5
use strict;
use warnings;
use POSIX 'strftime';
use Term::ANSIColor;
use File::Copy;
use Getopt::Std;
use File::Basename;
use vars qw($opt_r $opt_a);
getopts('ra');
use Data::Dumper;
use Text::Table;

my ($name,$path,$suffix) = fileparse($0);
my $date = strftime ('%Y-%m-%d', localtime);
open(my $fh, ">", "$path$date".'xx') or die "cannot open < input.txt: $!";
opendir my $directory , $path or die $!;
my @files = grep !/^\./, readdir $directory;
unlink "$path$date".'xx' or die "Can't unlink $!";

if ( $opt_r ) #Delete the entries corresponding to the arguments given.
{
	foreach my $arg (@ARGV) #Move these files to the archive.
	{
		move($path."/$files[$arg-1]","$path".'/.archive/'."$files[$arg-1]") or die "The move failed: $!";
		print "Deleted: $files[$arg-1]\n";
	}
}
elsif( $opt_a ) #create filename having underscores between the arguments. Do some processing based on whether begins with date.
{
	my @metadata = ('','','','',''); #Date>Author>Title>Email>Tags
	foreach my $arg (@ARGV)
	{
		if (substr($arg,0,1) eq '2' || substr($arg,0,1) eq '1'){$metadata[0] = $metadata[0].$arg.'_'}
		elsif (substr($arg,0,1) eq ':'){$metadata[4] = $metadata[4].$arg.'_'}
		elsif (substr($arg,0,1) eq uc(substr($arg,0,1))){$metadata[1] = $metadata[1].$arg.'_'}
		elsif ($arg =~ '@'){$metadata[3] = $metadata[3].$arg.'_'}
		else {$metadata[2] = $metadata[2].$arg.'_'}
	}
	@metadata = map {join '_' , @{$_} } @metadata unless (! defined $_);
	@metadata = map {defined $_ ? $_:''} @metadata;
	#print Dumper (\@metadata);
	my $new_filename = join ( '>' , @metadata );
	print "$new_filename\n";
	open my $new_file, '>' , "$path/$new_filename" or die "Couldn't open: $!";
	close $new_file;
}
else #Print entries that match the arguments. If no arguments print all.
{
	my $count = 1;
	my $final_email;
	my $matches = Text::Table->new(my $file_no,my $file_date,my $file_author,my $file_title,my $file_email,my $file_tags);
	#my $matches = Text::Table->new();
	foreach my $file (@files) #Pretty print the ones that match and copy the last one to the clipboard
	{
		if ( ! @ARGV){@ARGV = ''}
		if (map {$file =~ $_} @ARGV) #Check for matches 
		{
			#Split up file and replace underscores with spaces
			my @values = split />/ , $file , -1;
			#If only date print in red and don't increment count
			if((! defined $values[1]) && (! defined $values[2]) && (! defined $values[3]))
			{
				$values[0]= colored($values[0],'red');
				unshift @values , "";
				$matches->add(@values);
			}
			else{
			$final_email = $values[3];
			my ($file_name,$file_path,$file_suffix) = fileparse("$path"."$values[-1]" , '\.[^\.]*');
			$values[-1] = $file_name;
			unshift @values , colored($count,'green').' - ';
			$values[1]= colored($values[1],'yellow');
			$values[2]= colored($values[2],'blue');
			$values[4]= colored($values[4],'blue');
			for my $value (@values){$value =~ s/_/ /g unless (! defined $value);}
			$matches->add(@values);
			}
			$count ++;
		}
	}
	#If there is an email address in the file copy it to the clipboard
	open (TO_CLIPBOARD, "|pbcopy");
	print TO_CLIPBOARD $final_email ,"" unless (! defined $final_email);
	print $matches;
	closedir $directory;
}
#print join("\n", map { s|/|::|g; s|\.pm$||; $_ } keys %INC);
