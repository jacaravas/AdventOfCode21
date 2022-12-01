use strict;
use warnings;
use Data::Dumper;

my @calls;
my $boards;

open (my $in_fh, "<", "data.txt") or die $!;
my $call_row = <$in_fh>;

$call_row =~ s/\s+//g;
@calls = split (",", $call_row);

my $skip = <$in_fh>;

my $board = 0;
my $row = 0;
while (my $line = <$in_fh>) {
    $line =~ s/\R+//;
    unless ($line =~ m/\S/) {
        $board++;
        $row = 0;
        next;
    }
    my @cols = split (/\s+/, $line);
    $boards -> [$board] -> [$row] = \@cols;
    $row++;
}

print Dumper ($boards);
foreach my $call (@calls) {
    foreach my $board (@$boards) {
        if (FindMatch ($board, $call)) {
            CalcScore ($board, $call);
            die;
        }
    }
}

sub FindMatch {
    my ($board, $call) = @_;
    for(my $i = 0; $i < @$board; $i++) {
        for(my $j = 0; $j < @{$board -> [$i]}; $j++) {
            print $call, "\t", $i, "\t", $j, "\n", Dumper ($board), "\n";
            if ($board -> [$i] -> [$j] eq $call) {
                $board -> [$i] -> [$j] = "X";
                if (CheckRow ($board, $i)) {
                    return 1;
                }
                if (CheckCol ($board, $j)) {
                    return 1
                }
            }
        }
    }
    return (0, $board);
}

sub CheckRow{
    my ($board, $i) = @_;  
    for (my $j = 0; $j < @{$board -> [$i]}; $j++) {
        if ($board -> [$i] ->[$j] =~ m/\d/) {
            return 0;
        }
    }
    return 1;
}
        
sub CheckCol{
    my ($board, $j) = @_;  
    for (my $i = 0; $i < @$board; $i++) {
        if ($board -> [$i] ->[$j] =~ m/\d/) {
            return 0;
        }
    }
    return 1;
}

sub CalcScore {
    my ($board, $call) = @_;
    my $sum = 0;
    for(my $i = 0; $i < @$board; $i++) {
        for(my $j = 0; $j < @{$board -> [$i]}; $j++) {
            if ($board -> [$i] ->[$j] =~ m/\d/) {
                $sum += $board -> [$i] ->[$j];
            }
        }
    }
    $sum *= $call;
    print $sum, "\n";
}
      
# # my $ref;
# # $ref -> {"hat"} = 1;
# # my $val = $ref-> {"hat"};
# # print ref $tree -> {0};

# print CountChildren($tree), "\n";
# print CountChildren($tree -> {0}), "\n";

# $count = 0;
# # #OxGen
# my $ox_gen = OxGen($tree -> {1});

# print $ox_gen, "\n";


# sub BinaryConvert {
    # my $arg = shift;
    # my @val = reverse (@$arg);
    # my $answer = 0;
    # for (my $i = 0; $i < @val; $i++){
        # $answer += $val[$i] * (2 ** $i)
    # }
    # return $answer;
# }

# sub CountChildren {
    # my $branch = shift;  
    # my $total = 0;
    # foreach my $key (keys %$branch) {
        # if (ref $branch -> {$key}) {
            # $total += CountChildren($branch -> {$key});
        # }
        # else {
            # $total++;
        # }
    # }
    # return $total;
# }
    
# sub OxGen {
    # my $branch = shift;
    # my $result;

    # my @totals= qw ( 0 0 );
    
    # unless (ref $branch) {
        # print "Returning ", $branch , "\n";
        # if (exists ($branch -> {0})) {
            # print "0:", $branch -> {0}, "\n";
        # }
        # if (exists ($branch -> {1})) {
            # print "1:", $branch -> {1}, "\n";
        # }
        # "Dumper:", Dumper (%$branch);
        # print $branch -> {0}, "\t", $branch -> {1}, "\n";
        # return $branch;
    # }
    
    # foreach my $key (keys %$branch) {
        # $totals[$key] = CountChildren ($branch -> {$key});
        # print "Branch: ", $branch, " Key: ", $key, " Val: ", $branch -> {$key}, "\n";
    # }
    # print $totals[0], "\t", $totals[1], "\n";
    # if ($totals[0] < $totals[1]) {
        # $result = OxGen ($branch -> {0});
    # }
    # else {
        # $result = OxGen ($branch -> {1});   
    # }
    # return $result;
# }    
    # # if (exists $branch -> {0}) {
        # # if (ref ($branch -> {0})) {
            # # $total_0 = CountChildren ($branch -> {0});
            # # print "ref\n";
        # # }
        # # else {
            # # return $branch -> {"0"};
        # # }
    # # }
    # # else {
        # # print "NOPE!\n";
       # # # die;
    # # }
    # # if (exists $branch -> {1}) {
        # # if (ref ($branch -> {1})) {
            # # $total_1 = CountChildren ($branch -> {1});
            # # print "ref\n";
        # # }
        # # else {
            # # return $branch -> {1};
        # # }
    # # }
    # # else {
        # # print "NOPE!\n";
        # # die;
    # # }

    # # return $result 
# # }
    