use strict;
use warnings;
use Data::Dumper;

my @calls;
my $boards;

open (my $in_fh, "<", "data.txt") or die $!;
my $call_row = <$in_fh>;

$call_row =~ s/\s+//g;
@calls = split (",", $call_row);

my $skip = <$in_fh>;

my $board_num = 0;
my $row = 0;
while (my $line = <$in_fh>) {
    $line =~ s/\R+//;
    unless ($line =~ m/\S/) {
        $board_num++;
        $row = 0;
        next;
    }
    $line =~ s/\s+/ /g;
    my @cols = split (" ", $line);
    $boards -> [$board_num] -> [$row] = \@cols;
    $row++;
}

my $kept;
for (my $i = 0; $i < @$boards; $i++) {
    $kept -> {$i} ++;
}
foreach my $call (@calls) {
    foreach my $i (keys %$kept) {
        if (FindMatch ($i, $call)) {
            my $sum = CalcScore($i, $call);
            if ( (keys %$kept) == 1){
                print "$sum\n";
                die;
            }
            delete ($kept -> {$i});
        }
    }
}

sub FindMatch {
    my ($i, $call) = @_;
    for(my $j = 0; $j < @{$boards -> [$i]}; $j++) {
        for(my $k = 0; $k < @{$boards -> [$i] -> [$j]}; $k++) {
            if ($boards -> [$i] -> [$j] -> [$k] eq $call) {
                $boards -> [$i] -> [$j] -> [$k] = "X";
                if (CheckRow ($i, $j)) {
                    return 1;
                }
                if (CheckCol ($i, $k)) {
                    return 1
                }
            }
        }
    }
    return 0;
}

sub CheckRow{
    my ($i, $j) = @_;  
    for (my $k = 0; $k < @{$boards -> [$i] -> [$j]}; $k++) {
        if ($boards -> [$i] -> [$j] -> [$k] =~ m/\d/) {
            return 0;
        }
    }
    return 1;
}
        
sub CheckCol{
    my ($i, $k) = @_;  
    for (my $j = 0; $j < @{$boards -> [$i]}; $j++) {
        if ($boards -> [$i] -> [$j] -> [$k] =~ m/\d/) {
            return 0;
        }
    }
    return 1;
}

sub CalcScore {
    my ($i, $call) = @_;
    my $sum = 0;
    for(my $j = 0; $j < @{$boards -> [$i]}; $j++) {
        for(my $k = 0; $k < @{$boards -> [$i] -> [$j]}; $k++) {
            if ($boards -> [$i]-> [$j] ->[$k] =~ m/\d/) {
                $sum += $boards -> [$i]  -> [$j] ->[$k];
            }
        }
    }
    $sum *= $call;
    return $sum;
}
