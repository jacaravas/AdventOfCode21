use strict;
use warnings;

open (my $in_fh, "<", "data.txt") or die $!;

my $end = 256;
my @adult_fish;
my $current_fish;
while (my $line = <$in_fh>) {
    $line =~ s/\R+//g;
    my @fish = split (",", $line);
    $current_fish = @fish;
    foreach my $fish (@fish) {
        $adult_fish[$fish]++;
    }
}
for (my $i = 0; $i <$end; $i++) {
    unless (exists $adult_fish[$i]) {
        next;
    }
    $adult_fish[$i + 7] += $adult_fish[$i];
    $adult_fish[$i + 9] += $adult_fish[$i];
    $current_fish += $adult_fish[$i];
}
print "$current_fish\n";



    
 