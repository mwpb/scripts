use strict;
use warnings;
use Tie::File;

#Put the files into an array
my $path = '~/vimwiki';
opendir my $directory , $path or die $!;
my @files = grep !/^\./, readdir $directory;

#Create hash for elements and arrays to put them in.
my %elements = ('Lemma' => [], 'Definition' => [], 'Notation' => [], 'Proposition' => []);

foreach my $file (@files)
{
  foreach my $element (keys %elements) #Put found elements in appropriate position in index.
  {
    my @filename = split /\./ , $file;
    tie my @lines , 'Tie::File' , '~/vimwiki/'."$file" or die "Cannot tie file: $!";
    if ($lines[0] eq "$element".'::'){push $elements{$element} , "[[$filename[0]]]";}
    if ($lines[0] eq "$element".'::TODO'){push $elements{$element} , "TODO [[$filename[0]]]";}
    untie @lines;
  }
}
#Write this to the index file.
tie my @index_file , 'Tie::File' , '~/vimwiki/index.wiki' or die "Cannot tie file: $!";
@index_file = ('=Index=', '');
foreach my $element (keys %elements)
{
  push @index_file , '';
  push @index_file , "==$element".'s==';
  push @index_file , '';
  foreach my $instance (@{$elements{$element}})
  {
    push @index_file , $instance;
    push @index_file , '';
  }
}
untie @index_file;
