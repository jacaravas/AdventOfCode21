use strict;
use warnings;

my $depth = 0;
my $horiz = 0;
my $aim = 0;

open (my $in_fh, "<", "data.txt") or die $!;
while (my $line = <$in_fh>) {
    $line =~ m/(\S+)\s+(\d+)/;
    if ($1 eq "forward") {
        $horiz += $2;
        $depth += ($aim * $2);
    }
    elsif ($1 eq "down") {
        $aim += $2;
    }
    elsif ($1 eq "up") {
        $aim -= $2;
    }


}
print "Depth: $depth\n";
print "Horiz: $horiz\n";
my $result = $horiz * $depth;
print "Result: $result\n";
