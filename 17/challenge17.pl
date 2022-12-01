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

# print Dumper ($height_map), "\n";

my $total_risk = 0;

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
        # print "$total\t";
        if ($total == 0) {
            # print "$i,$j\n";
            $total_risk += ($cur + 1);
        }
        if (( $i== 64) && ($j == 0)) {
            # print Dumper ($height_map), "\n";
            print Dumper ($height_map -> [$i-1]), "\n";
            print Dumper ($height_map -> [$i]), "\n";
            print Dumper ($height_map -> [$i+1]), "\n";           
            
        }
        # print "\n";
    }
}
print "$total_risk\n";
