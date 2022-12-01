use strict;
use warnings;
use Data::Dumper;

open (my $in_fh, "<", "data.txt") or die $!;

my $map;
my $sum = 0;
while (my $in = <$in_fh>) {
    $in =~ s/\R+//g;
    unless ($in =~ m/\S/) {
        next;
    }
    $in =~ m/(\d+),(\d+) -> (\d+),(\d+)/;
    if (($1 == $3) || ($2 == $4)) {
        DrawLine($1, $2, $3, $4);
    }
}

print "$sum\n";
$sum = 0;
foreach my $x (keys %$map) {
    foreach my $y (keys %{$map -> {$x}}) {
        if ($map -> {$x} -> {$y} >1) {
            $sum++;
        }
    }
}
print "$sum\n";

sub DrawLine {
    my ($x1, $y1, $x2, $y2) = @_;
    
    if ($x1 == $x2) {
        print "X $x1, $y1 and $x2, $y2\n";
        my @y_range = ($y1, $y2);
        @y_range = sort { $a <=> $b } @y_range;
        print $y_range[0], ",", $y_range[1], "\n";
        for (my $i = $y_range[0]; $i <= $y_range[1]; $i++) {
            if (exists $map -> {$x1} -> {$i}) {
                if ($map -> {$x1} -> {$i} == 1) {
                    $sum++;
                }
            }
            $map -> {$x1} -> {$i} ++;
            print "$x1, $i\t", $map -> {$x1} -> {$i}, "\n";
        }
    }
    if ($y1 == $y2) {
        my @x_range = ($x1, $x2);
        @x_range = sort { $a <=> $b } @x_range;
        print "Y $x1, $y1 and $x2, $y2\n";
        print $x_range[0], ",", $x_range[1], "\n";        
        for (my $i = $x_range[0]; $i <= $x_range[1]; $i++) {
            if (exists $map -> {$i} -> {$y1}) {
                if ($map -> {$i} -> {$y1} == 1) {
                    $sum++;
                }
            }
            $map -> {$i} -> {$y1} ++;
            print "$i, $y1\t", $map -> {$i} -> {$y1}, "\n";            
        }
    }  
}    