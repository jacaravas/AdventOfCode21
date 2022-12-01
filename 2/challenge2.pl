use strict;
use warnings;

my $last;
my $increased = 0;

my @rows;
open (my $in_fh, "<", "data.txt") or die $!;
while (my $line = <$in_fh>) {
    $line =~ s/\R+//g;
    push (@rows, $line);
}

for (my $i = 2; $i < @rows; $i++) {
    my $val = $rows[$i] + $rows[$i-1] + $rows[$i-2];
    if ( (defined $last) && ($val> $last) ) {
        $increased++;
    }
    $last = $val;
}
print $increased;