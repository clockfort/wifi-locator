#!/usr/bin/perl

use XML::Simple;
use Data::Dumper;
use strict;
use warnings;
use profiles;

#Could take a while.
print "Starting profile import...\n";
import_profile_data("rt2860");
print "Done with profile import.\n";

my $xml = new XML::Simple;

open(my $XML_INPUT, "./iwlist ra0 scan |");

my $data = $xml->parse_fh($XML_INPUT);

my @cells;

#Populate array of cells
foreach my $cell (@{$data->{cell}}){
	my %current_cell = xml_cell_to_hash_cell($cell);
	push(@cells,\%current_cell);
}


#Testing sorting
my @sorted_cells = sort { ${$a}{'signal'} <=> ${$b}{'signal'} } @cells;
foreach my $cell (@sorted_cells){
	print ${$cell}{'signal'}, "\n";
}

