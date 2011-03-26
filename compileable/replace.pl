#!/usr/bin/perl

use strict;
use warnings;

unless (scalar(@ARGV) >= 4) {
 die("Usage: ./replace.pl infile outfile key replacement [--last-line]\n\n--last-line deletes all lines after the key")
}

unless(open(In1,$ARGV[0])) {
 die("Could not open $ARGV[0]")
}
unless(open(Out,">$ARGV[1]")) {
 die("Could not open $ARGV[1] for writing.")
}
unless(open(In2,$ARGV[3])) {
 die("Could not open $ARGV[3]")
}

my $killAll = 0;
if (scalar(@ARGV) == 5 && $ARGV[4] eq "--last-line") {
 $killAll = 1;
}

my @rep = ();
until (eof(In2)) {
my $line = <In2>;
push(@rep,$line)
}
close(In2);


my $key = $ARGV[2];
until (eof(In1)) {
my $line = <In1>;
chomp($line);
if ($line eq $key) {
 foreach my $rep (@rep) {
  print Out "$rep";
 }
 if ($killAll) {
  last;
 }
} else {
 print Out "$line\n"
}

}
close(In1);
close(Out);
