#!/usr/bin/perl

use XML::Simple;
use Data::Dumper;
use strict;
use warnings;


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


#current xml keys: 'frequency', 'signal', 'address', 'quality', 'essid', 'noise'
sub xml_cell_to_hash_cell {	
	my $cell = shift;
        my %current_cell = ();
        $current_cell{'frequency'} = $cell->{frequency};
        $current_cell{'signal'} = $cell->{signal};
        $current_cell{'signal'} =~ s/ dBm//;
        $current_cell{'address'} = $cell->{address};
        $current_cell{'quality'} = $cell->{quality};
        $current_cell{'essid'} = $cell->{essid};
        $current_cell{'noise'} = $cell->{noise};
	return %current_cell;
}
