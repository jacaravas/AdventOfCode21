use strict;
use warnings;
use Data::Dumper;

my $tree;
my $count = 0;
my $depth = 12;

open (my $in_fh, "<", "test_data.txt") or die $!;
while (my $line = <$in_fh>) {
    $line =~ s/\R+//;
    my @row = split ("", $line);
    $tree -> {$row[0]} ->{$row[1]} -> {$row[2]} -> {$row[3]} -> {$row[4]} = $line;
    # $tree -> {$row[0]} ->{$row[1]} -> {$row[2]} -> {$row[3]} -> {$row[4]} -> {$row[5]} -> {$row[6]} -> {$row[7]} -> {$row[8]} -> {$row[9]} -> {$row[10]} -> {$row[11]} = $line;
    $count ++;
}

print Dumper ($tree), "\n";

# my $ref;
# $ref -> {"hat"} = 1;
# my $val = $ref-> {"hat"};
# print ref $tree -> {0};

print CountChildren($tree), "\n";
print CountChildren($tree -> {0}), "\n";

$count = 0;
# #OxGen
my $ox_gen = OxGen($tree);

print $ox_gen, "\n";


sub BinaryConvert {
    my $arg = shift;
    my @val = reverse (@$arg);
    my $answer = 0;
    for (my $i = 0; $i < @val; $i++){
        $answer += $val[$i] * (2 ** $i)
    }
    return $answer;
}



sub CountChildren {
    my $branch = shift;  
    my $total = 0;
    foreach my $key (keys %$branch) {
        if (ref $branch -> {$key}) {
            $total += CountChildren($branch -> {$key});
        }
        else {
            $total++;
        }
    }
    return $total;
}

sub OxGen {
    my $branch = shift;
    my $result;

    my @totals= qw ( 0 0 );
    
    if (exists $branch -> {"0"}) {
        if (ref $branch -> {"0"}) {
            $totals["0"] = CountChildren ($branch -> {"0"});
            print "Branch: ", $branch, " Key: ", "0", " Val: ", $branch -> {"0"}, "\n";
        }
        else {
            return $branch -> {"0"};
        }
    }
    if (exists $branch -> {"1"}) {
        if (ref $branch -> {"1"}) {
            $totals["1"] = CountChildren ($branch -> {"1"});
            print "Branch: ", $branch, " Key: ", "1", " Val: ", $branch -> {"1"}, "\n";
        }
        else {
            return $branch -> {"1"};
        }
    }
    print $totals[0], "\t", $totals[1], "\n";
    if ($totals[0] < $totals[1]) {
        $result = OxGen ($branch -> {0});
    }
    else {
        $result = OxGen ($branch -> {1});   
    }
    return $result;
}    

    
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
        # print "Dumper:", Dumper ($branch);
        # # print $branch -> {0}, "\t", $branch -> {1}, "\n";
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

    