#!/usr/bin/perl

use XML::Simple;
use Data::Dumper;
use strict;
use warnings;


my $xml = new XML::Simple;

open(my $XML_INPUT, "./iwlist ra0 scan |");

my $data = $xml->parse_fh($XML_INPUT);
print Dumper($data);
