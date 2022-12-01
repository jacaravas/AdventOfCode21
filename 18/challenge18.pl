use strict;
use warnings;
use Data::Dumper;

open (my $in_fh, "<", "data.txt") or die $!;

my $height_map;

my $i = 0;

while (my $line = <$in_fh>) {
    $line =~ s/\R+//g;
    my @row = split ("", $line);
    $height_map -> [$i] = \@row;
    $i++;
}

my @basins;
my $basin;
for (my $i = 0; $i < @$height_map; $i++) {
    for (my $j = 0; $j < @{$height_map -> [$i]}; $j++) {
        my $total = 0;
        my $cur = $height_map -> [$i] -> [$j];
        my $test_coords = [ [$i, $j-1], [$i, $j+1], [$i-1, $j], [$i+1, $j] ];
        foreach my $test (@$test_coords) {
            if ( ($test-> [0] >= 0) && ($test -> [1] >=0) && (exists $height_map -> [$test -> [0]] -> [$test -> [1]])) {
                $total++;
                if ($height_map -> [$test -> [0]] -> [$test -> [1]] > $cur) {
                    $total--;                   
                }
            }
        }
        if ($total == 0) {
            $basin = {};
            FindBasin ($i, $j, $height_map -> [$i] -> [$j]);
            my $basin_size = keys %$basin;
            push (@basins, $basin_size);
        }
    }
}

@basins = sort {$b <=> $a} @basins;
my $result = $basins[0] * $basins[1] * $basins[2];
print "$result\n";

sub FindBasin {
    my ($i, $j, $last) = @_;
    if (exists $basin -> {"$i,$j"}) {
        return 0;
    }
    if ( ($i < 0) || ($j < 0) ) {
        return 0;
    }
    unless (exists $height_map -> [$i] -> [$j]) {
        return 0;
    }
    my $val = $height_map -> [$i] -> [$j];
    if  (($val == 9) || ($last > $val)) {
        return 0;
    }
    $basin -> {"$i,$j"} = 1;
    FindBasin ($i-1, $j, $val);
    FindBasin ($i+1, $j, $val);
    FindBasin ($i, $j+1, $val);
    FindBasin ($i, $j-1, $val);
}
 
