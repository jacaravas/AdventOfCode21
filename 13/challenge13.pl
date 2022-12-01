use strict;
use warnings;

open (my $in_fh, "<", "data.txt") or die $!;

my @crab_positions;

while (my $line = <$in_fh>) {
    $line =~ s/\R+//g;
    my @crabs = split (",", $line);
    foreach my $crab (@crabs) {
        $crab_positions[$crab]++;
    }
}

my $best_fuel;
my $best_pos;
for (my $i = 0; $i <@crab_positions; $i++) {
    my $fuel_use = 0;
    for (my $j = 0; $j <@crab_positions; $j++) {
        if (exists $crab_positions[$j]) {
            $fuel_use += ($crab_positions[$j] * CalcFuel (abs($j - $i)));
        }
    }
    if ( (!defined $best_fuel) || ($fuel_use < $best_fuel)) {
        $best_fuel = $fuel_use;
        $best_pos = $i;
    }
}
print "$best_pos\t$best_fuel\n";

sub CalcFuel {
    my $dist = shift;
    return ( ($dist * ($dist + 1)) / 2);
}
    



    
 