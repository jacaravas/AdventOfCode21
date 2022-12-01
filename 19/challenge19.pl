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
              
my %score =  (  ")" => 3,
                "]" => 57,
                "}" => 1197,
                ">" => 25137
              );              
 
my $error_sum = 0;

open (my $in_fh, "<", "data.txt") or die $!;

while (my $line = <$in_fh>) {
    $line =~ s/\R+//g;
    my @delims = split ("",$line);
    my @stack;
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
                $error_sum += $score{$delims[$i]};
                last;
            }
        }        
    }
}
print "$error_sum\n";