use strict;
use warnings;
use Data::Dumper;

my %closers = ( ")" => "(",
                "]" => "[",
                "}" => "{",
                ">" => "<"
              );

my %openers = ( "(" => ")",
                "[" => "]",
                "{" => "}",
                "<" => ">"
              );              
              
my %score =  (  ")" => 1,
                "]" => 2,
                "}" => 3,
                ">" => 4
              );              

my @score_arr;

open (my $in_fh, "<", "data.txt") or die $!;

while (my $line = <$in_fh>) {
    $line =~ s/\R+//g;
    my @delims = split ("",$line);
    my @stack;
    my $corrupted = 0;
    for (my $i = 0; $i < @delims; $i++) {
        if (exists $openers{$delims[$i]}) {
            push (@stack, $delims[$i])
        }
        else {
            if ($stack[-1] eq $closers{$delims[$i]}){
                pop @stack;
            }
            else {
                print "Expected ", $openers{$stack[-1]}, ". Found ", $delims[$i], " at position $i\n";
                $corrupted++;
                last;
            }
        }        
    }
    if ($corrupted) {
        next;
    }
    my $line_score = 0;
    foreach my $val (reverse @stack) {
        $line_score *= 5;
        $line_score += $score{$openers{$val}};
        print "$val\t", $openers{$val}, "\n";
    }
    print "$line_score\n";
    push @score_arr, $line_score;
    
}
@score_arr = sort {$a <=> $b} @score_arr;
my $midpoint = int (@score_arr / 2);
print $score_arr[$midpoint], "\n";


