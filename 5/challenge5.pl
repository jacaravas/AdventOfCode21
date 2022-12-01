use strict;
use warnings;

my $total = 0;
my @sums;

open (my $in_fh, "<", "data.txt") or die $!;
while (my $line = <$in_fh>) {
    $line =~ s/\R+//;
    $total ++;
    my @row = split ("", $line);

    for (my $i = 0; $i < @row; $i++) {
        $sums[$i] += $row[$i];
    }
}
my $target = $total/2;

my @gamma;
my @epsilon;

for (my $i = 0; $i < @sums; $i++) {
    if ($sums[$i] > $target) {
        $gamma[$i] = 1;
        $epsilon[$i] = 0;
    }
    else {
        $gamma[$i] = 0;
        $epsilon[$i] = 1;
    }
}
my $gamma_int = BinaryConvert(\@gamma);
my $epsilon_int = BinaryConvert(\@epsilon);

print $gamma_int, "\n";
print $epsilon_int, "\n";
print $gamma_int * $epsilon_int;

sub BinaryConvert {
    my $arg = shift;
    my @val = reverse (@$arg);
    my $answer = 0;
    for (my $i = 0; $i < @val; $i++){
        $answer += $val[$i] * (2 ** $i)
    }
    return $answer;
}

    