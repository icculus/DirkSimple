#!/usr/bin/perl -w

# This is a giant hack of a piece of code, as one would expect from a Perl
#  script chewing through some custom data.
#
# I coerced RomSpinner to Console.WriteLine() the text of each treenode in
#  the flow window text after creation, and then used this to process all
#  that data so I wouldn't have to manually enter it while clicking through
#  its UI.
#
# The data still needs manual cleanup after this, but this does a _ton_ of
#  heavy lifting.
#
# This script is public domain. God knows what you would use it for, though.

use warnings;
use strict;

my $savestr = undef;

sub parse_sequence {
    my $seqname = shift;
    my $sceneref = shift;
    my $seqindent = shift;
    my $metadata = shift;
    my $sequence = "$metadata\n";

    #print("parse_sequence: considing new sequence $seqname\n");

    while (1) {
        my $str = $savestr;
        if (defined $str) {
            $savestr = undef;
        } else {
            $str = <>;
            last if (not defined $str);
        }

        my $origstr = "$str";

        chomp($str);
        #print("parse_sequence: consider str '$str'\n");

        $str =~ /\A(\s*)(.*)\Z/;
        $str = $2;
        my $indentation = length($1);

        if ($indentation < $seqindent) {
            $savestr = $origstr;
            last;
        }

        if ($str =~ /\ASequence (\d+) \- (.*)\Z/) {
            my $newseq = undef;
            # reorder these so start dead sorts first.
            if ($1 == 0) {  # start alive
                $newseq = "-1";
            } elsif ($1 == 1) {  # start dead
                $newseq = "-2";
            } else {
                $newseq = "seq$1";
            }

            $sequence .= "Goto $newseq\n";
            my $seq = parse_sequence($newseq, $sceneref, $indentation + 1, $2);
            if (not defined $$sceneref{$newseq}) {
                $$sceneref{$newseq} = $seq;
                #print("parse_sequence: ADDED SEQUENCE $newseq:\n$seq\n\n");
            } else {
                #print("parse_sequence: ALREADY HAVE SEQUENCE $newseq\n");
            }
            #print("parse_sequence: back to considering sequence '$seqname'\n");
        } else {
            $sequence .= "$str\n";
        }
    }

    #print("parse_sequence: finished with sequence '$seqname'\n");
    return $sequence;
}


sub parse_scene {
    my %scene = ();

    while (1) {
        my $str = $savestr;
        if (defined $str) {
            $savestr = undef;
        } else {
            $str = <>;
            last if (not defined $str);
        }

        chomp($str);
        #print("parse_scene: consider str '$str'\n");

        $str =~ /\A(\s*)(.*)\Z/;

        $str = $2;
        my $indentation = length($1);

        if ($str eq 'If Dirk Completed Previous Scene') {
            next; #$scene{"start_alive"} = "Goto seq0;\n"
        } elsif ($str eq 'If Dirk Died on Previous Scene') {
            next; #$scene{"start_dead"} = "Goto seq1;\n"
        } elsif ($str eq '---') {
            last;
        } elsif ($str =~ /\ASequence (\d+) \- (.*)\Z/) {
            my $newseq = undef;
            # reorder these so start dead sorts first.
            if ($1 == 0) {  # start alive
                $newseq = "-1";
            } elsif ($1 == 1) {  # start dead
                $newseq = "-2";
            } else {
                $newseq = "seq$1";
            }

            my $seq = parse_sequence($newseq, \%scene, $indentation + 1, $2);
            if (not defined $scene{$newseq}) {
                $scene{$newseq} = $seq;
                #print("parse_scene: ADDED SEQUENCE $newseq:\n$seq\n\n");
            } else {
                #print("parse_scene: ALREADY HAVE SEQUENCE $newseq\n");
            }
        } else {
            die("Unexpected sequence name '$str'\n");
        }
    }

    return \%scene;
}


my %scenes = ();

while (<>) {
    chomp;
    if (/\ASCENE '(.*)'/) {
        my $scenename = $1;
        $scenename =~ s/\A(.*) \- .*\Z/$1/;
        #print("$scenename\n");
        $scenes{$scenename} = parse_scene();
        #last;
    }
}


foreach (sort keys(%scenes)) {
    my $scenename = $_;
    my $sceneref = $scenes{$scenename};
    my %points = ();

    foreach ( sort { my $aa = "$a"; my $bb = "$b"; $aa =~ s/\Aseq//; $bb =~ s/\Aseq//; return $aa <=> $bb; } keys(%$sceneref)) {
        my $seqname = $_;
        my $seqstr = $$sceneref{$seqname};
        foreach(split(/\n/, $seqstr)) {
            chomp;
            #print("$seqname LINE $_\n");
            if (/\ASeek (\& Play Frame (\d+)|Ignored)( \- \+(\d+) points)\Z/) {
                $points{$seqname} = int($4);
                #print("SEQ $seqname $4 points ('$_')\n");
            }
        }
    }

    print("\n    [\"$scenename\"] = {\n");
    foreach ( sort { my $aa = "$a"; my $bb = "$b"; $aa =~ s/\Aseq//; $bb =~ s/\Aseq//; return $aa <=> $bb; } keys(%$sceneref)) {
        my $seqname = $_;
        my $seqstr = $$sceneref{$seqname};

        #print($seqstr);
        my $timeout = '';
        my $seek = '';
        my $kills_player = '';
        my $timeoutnextseq = '';
        my $timeoutpoints = '';
        my $pending_action = undef;
        my $actions = '';

        foreach(split(/\n/, $seqstr)) {
            chomp;
            if (/\ASeek (\& Play Frame (\d+)|Ignored)( \- \+(\d+) points|)\Z/) {
                #print("SEEK orig='$_', \$1='$1', \$2='$2',\$3='$3',\$4='$4'\n");
                my $seekstr = $1;
                my $seekframe = $2;
                if ($seekstr eq 'Ignored') {
                    $seek = 'time_laserdisc_noseek()';
                } else {
                    $seek = "time_laserdisc_frame($seekframe)";
                }
            } elsif (/\ADeath - \d+ Total Points\Z/) {
                $kills_player = "            kills_player = true,\n";
                $timeoutnextseq = 'nil';
            } elsif (/\Success - \d+ Total Points\Z/) {
                $timeoutnextseq = 'nil';
            } elsif (/\ATimeout after (.*?) seconds\Z/) {
                my $ms = int(($1 * 1000.0) + 0.5);
                $timeout = "time_to_ms(" . int($ms / 1000.0) . ", " . ($ms % 1000) . ")";
            } elsif (/\A(Up|Down|Left|Right|UpLeft|UpRight|DownLeft|DownRight|Sword) \((.*?) to (.*?) elapsed seconds\)\Z/) {
                my $actionstr = $1;
                my $fromms = int(($2 * 1000.0) + 0.5);
                my $toms = int(($3 * 1000.0) + 0.5);
                my $from = "time_to_ms(" . int($fromms / 1000.0) . ", " . ($fromms % 1000) . ")";
                my $to = "time_to_ms(" . int($toms / 1000.0) . ", " . ($toms % 1000) . ")";

                $actionstr =~ tr/A-Z/a-z/;
                $actionstr = 'action' if $actionstr eq 'sword';
                $pending_action = "input=\"$actionstr\", from=$from, to=$to";
            } elsif (/\AGoto (seq\d+)\Z/) {
                my $nextseqname = $1;
                my $nextseqnamestr = ($nextseqname eq 'nil') ? 'nil' : "\"$nextseqname\"";
                my $pointsstr = defined $points{$nextseqname} ? (", points=" . $points{$nextseqname}) : '';
                if (defined $pending_action) {
                    $actions .= "                { $pending_action, nextsequence=$nextseqnamestr$pointsstr },\n";
                } else {
                    $timeoutnextseq = $nextseqname;
                    $timeoutpoints = $pointsstr;
                }
                $pending_action = undef;
            } elsif (/\AGo to Sequence \d+ of Next Scene\Z/) {
                next;  # ignore this.
            } else {
                die("Unexpected sequence line '$_' on ['$scenename']:$seqname\n");
            }
        }

        if ($seqname eq '-1') {
            print("        start_alive = {\n");
            print("            start_time = time_laserdisc_noseek(),\n");
            print("            timeout = { when=0, nextsequence=\"enter_room\", points = 49 }\n");
            print("         },\n");
            print("\n");
            print("        enter_room = {\n");
        } elsif ($seqname eq '-2') {
            print("        start_dead = {\n");
        } else {
            print("        $seqname = {\n");
        }

        my $timeoutnextseqstr = ($timeoutnextseq eq 'nil') ? 'nil' : "\"$timeoutnextseq\"";

        print("            start_time = $seek,\n");
        print($kills_player);
        print("            timeout = { when=$timeout, nextsequence=$timeoutnextseqstr$timeoutpoints }");

        if ($actions ne '') {
            print(",\n");
            print("            actions = {\n$actions            }");
        }
        print("\n");

        print("        },\n\n");

    }
    print("    },\n");
}

# end of romspin2dirksimple.pl ...

