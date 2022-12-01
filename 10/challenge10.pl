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
    DrawLine($1, $2, $3, $4);
}

print "$sum\n";

sub DrawLine {
    my ($x1, $y1, $x2, $y2) = @_;
    my @x_range = ($x1, $x2);
    @x_range = sort { $a <=> $b } @x_range;
    my @y_range = ($y1, $y2);
    @y_range = sort { $a <=> $b } @y_range;
    
    if ($x1 == $x2) {
        for (my $i = $y_range[0]; $i <= $y_range[1]; $i++) {
            if (exists $map -> {$x1} -> {$i}) {
                if ($map -> {$x1} -> {$i} == 1) {
                    $sum++;
                }
            }
            $map -> {$x1} -> {$i} ++;
        }
    }
    elsif ($y1 == $y2) {
        for (my $i = $x_range[0]; $i <= $x_range[1]; $i++) {
            if (exists $map -> {$i} -> {$y1}) {
                if ($map -> {$i} -> {$y1} == 1) {
                    $sum++;
                }
            }
            $map -> {$i} -> {$y1} ++;
        }
    }
    else {
        my @x_vals = ($x_range[0]..$x_range[1]);
        if ($x1 > $x2) {
            @x_vals = reverse(@x_vals);
        }
        my @y_vals = ($y_range[0]..$y_range[1]);
        if ($y1 > $y2) {
            @y_vals = reverse(@y_vals);
        }
        for (my $i = 0; $i < @x_vals; $i++) {
            print "$i\n";
            if (exists $map -> {$x_vals[$i]} -> {$y_vals[$i]}) {
                if ($map -> {$x_vals[$i]} -> {$y_vals[$i]} == 1) {
                    $sum++;
                }
            }
            $map -> {$x_vals[$i]} -> {$y_vals[$i]}++;
        }
    }
}    