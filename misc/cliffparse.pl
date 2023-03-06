#!/usr/bin/perl -w

use warnings;
use strict;


while (<>) {
    chomp;
    last if /\A\;\s+Begin Scene Data\Z/;
}

my $scenenum = 0;
my $scenename = '';
my $first_scene = 1;

sub calc_moves_array {
    my $str = shift;

    $str =~ tr/A-Z/a-z/;
    my @items = split /,/,$str;

    my $retval = '';
    my $comma = '';
    foreach (@items) {
        my $val = $_;
        $val =~ s/\s//g;
        if ($val ne 'none') {
            $retval .= "$comma\"$val\"";
            $comma = ', ';
        }
    }

    if ($retval eq '') {
        $retval = '{}';
    } else {
        $retval = "{ $retval }";
    }

    return $retval;
}

print("scenes = {\n");

while (<>) {
    chomp;

    last if (/;\s+unknown\Z/);  # past the scene table, stop.

    if (/\A;\s+Scene (.*?) \- (.*?)\Z/) {
        my $scenestr = $1;
        $scenename = $2;
        $scenename =~ s/\A\s*//;
        $scenename =~ s/\s*\Z//;

        $scenenum++;  # easy enough.
        #$scenename =~ tr/A-Z/a-z/;
        #$scenename =~ s/\s/_/g;
        #print("Now parsing Scene number $scenenum: '$scenename'\n");

        if ($first_scene) {
            $first_scene = 0;
        } else{
            print("        }\n");  # close off moves table
            print("    },\n");  # close off previous scene.
        }

        print("\n");
        print("    -- scene $scenenum\n");
        print("    {\n");
        print("        scene_name = \"$scenename\",\n");

        my $l;
        $l = <>; chomp($l); # skip ------- line
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Frame 0*(\d+)/) { print("        start_frame = $1,\n"); } else { die("Unexpected scene data 1: '$l'\n"); }
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Frame 0*(\d+)/) { print("        end_frame = $1,\n"); } else { die("Unexpected scene data 2: '$l'\n"); }
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Frame 0*(\d+)/) { print("        dunno1_frame = $1,\n"); } else { die("Unexpected scene data 3: '$l'\n"); }
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Frame 0*(\d+)/) { print("        dunno2_frame = $1,\n"); } else { die("Unexpected scene data 4: '$l'\n"); }
        $l = <>; chomp($l); # number of moves in this scene

        print("        moves = {\n");

    } elsif (/\A;\s+Difficulty (\d+):Scene (\d+):Move (\d+)/) {
        # We assume these are in order, so we don't care about the actual numbers listed.
        print("            {\n");

        my $m;
        my $l;
        $l = <>; chomp($l); # skip ------- line
        $l = <>; chomp($l); # skip .DB 000h line
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Correct Move\s*\=\s*(.*)/) { $m = calc_moves_array($1); print("                correct_moves = $m,\n"); } else { die("Unexpected move data 1: '$l'\n"); }
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Incorrect Move\s*\=\s*(.*)/) { $m = calc_moves_array($1); print("                incorrect_moves = $m,\n"); } else { die("Unexpected move data 2: '$l'\n"); }
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Move Start Frame:\s*0*(\d+)/) { print("                start_frame = $1,\n"); } else { die("Unexpected move data 3: '$l'\n"); }
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Move End Frame:\s*0*(\d+)/) { print("                end_frame = $1,\n"); } else { die("Unexpected move data 4: '$l'\n"); }
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Death Start Frame:\s*0*(\d+)/) { print("                death_start_frame = $1,\n"); } else { die("Unexpected move data 5: '$l'\n"); }
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Death End Frame:\s*0*(\d+)/) { print("                death_end_frame = $1,\n"); } else { die("Unexpected move data 6: '$l'\n"); }
        $l = <>; chomp($l); # skip Restart line
        $l = <>; chomp($l); if ($l =~ /\A.*?;\s*Restart: Move (\d+)/) { my $m = int($1) + 1; print("                restart_move = $m\n"); } elsif ($l =~ /\A.*?;\s*Restart/) { print("                restart_move = 1\n"); } else { die("Unexpected move data 7: '$l'\n"); }
        print("            },\n");
    }
}


print("        }\n");  # close off moves table
print("    }\n");  # close off previous scene.
print("}\n\n");  # close off previous scene.

exit(0);

