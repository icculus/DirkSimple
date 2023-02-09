#!/usr/bin/perl -w

use warnings;
use strict;

my @rows = ( '', '', '', '', '', '', '', '');
my $rowidx = 0;
my $skip = 0;

while (<>) {
    chomp;
    my $l = $_;

    if ($skip) {
        $skip = 0;
        next;
    }

    $l =~ s/\A(........).*\Z/$1/;

    $rows[$rowidx] .= ".$l.";

    $rowidx++;
    if ($rowidx >= 8) {
        $rowidx = 0;
        $skip = 1;
    }
}

print("! XPM2\n");
print('' . length($rows[0]) . " 8 2 1\n");
print("X c #FFFFFF\n");
print(". c #000000\n");
foreach (@rows) {
    print("$_\n");
}

exit(0);

