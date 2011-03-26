#!/usr/bin/perl

use strict;
use warnings;

unless (scalar(@ARGV) == 4) {
 die("Usage: ./replace.pl infile outfile start stop \n\n")
}

unless(open(In,$ARGV[0])) {
 die("Could not open $ARGV[0]")
}
unless(open(Out,">$ARGV[1]")) {
 die("Could not open $ARGV[1] for writing.")
}

my $start = $ARGV[2];
my $stop = $ARGV[3];

until (eof(In)) {
 my $line = <In>;
 chomp($line);
 if ($line =~m/$start/) {
  until (eof(In)) {
   $line = <In>;
   if ($line =~m/$stop/) {
    last;
   }
   print Out "#\' ".$line;
  }
 }
}
close(In);
close(Out);


