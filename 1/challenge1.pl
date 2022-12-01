use strict;
use warnings;

my $last;

my $increased = 0;
open (my $in_fh, "<", "data.txt") or die $!;
while (my $line = <$in_fh>) {
    $line =~ s/\R+//g;
    chomp $line;
    if ( (defined $last) && ($line > $last) ) {
        $increased++;
    }
    $last = $line;
}
print $increased;