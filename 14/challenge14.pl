use strict;
use warnings;
use Data::Dumper;

open (my $in_fh, "<", "data.txt") or die $!;

my @lcd = qw ( abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg);

my @digits;
my $encoded;
my $sum = 0;

while (my $line = <$in_fh>) {
    $line =~ s/\R+//g;
    $line =~ m/(.+)\s+\|\s+(.+)/;
    print "$1:$2\n";
    Decrypt ($1);
    $sum += Decode ($2);
}

print "$sum\n";
# my $answer = $digits[2] + $digits[3] + $digits[4] + $digits[7];
# print "$answer\n";

sub Decrypt {
    my $keys = shift;
    my $decrypter;
    $encoded = {};
    my @keys = split (/\s+/, $keys);
    
    foreach my $key (@keys) {
        if (length ($key) == 3){
            $encoded -> {"7"} = $key;
        }
        elsif (length ($key) == 2) {
            $encoded -> {"1"} = $key;
        }
        elsif (length ($key) == 4) {
            $encoded -> {"4"} = $key;
        }
        elsif (length ($key) == 7) {
            $encoded -> {"8"} = $key;
        }
    }
    $decrypter -> {"a"} = FindA (\@keys, $decrypter);
    FindNine(\@keys, $decrypter);
    $decrypter -> {"g"} = FindG (\@keys, $decrypter); 
    $decrypter -> {"e"} = FindE (\@keys, $decrypter);
    FindZero(\@keys, $decrypter);    
    $decrypter -> {"b"} = FindB (\@keys, $decrypter);
    $decrypter -> {"d"} = FindD (\@keys, $decrypter);
    FindSix(\@keys, $decrypter);        
    $decrypter -> {"c"} = FindC (\@keys, $decrypter);
    $decrypter -> {"f"} = FindF (\@keys, $decrypter);
    FindTwo(\@keys, $decrypter);
    FindThree(\@keys, $decrypter);
    FindFive(\@keys, $decrypter);
    print Dumper ($decrypter), "\n";    
     
}
sub FindA {
    my ($keys, $decrypter) = @_;
    my @desired_chars = split ("", $encoded -> {"7"});
    foreach my $char (@desired_chars) {
        unless ($encoded -> {"1"} =~ m/$char/) {
            return $char;
        }
    }
}
sub FindNine {
    my ($keys, $decrypter) = @_;
    my @desired_chars = split ("", $encoded -> {"4"});
    push (@desired_chars, $decrypter -> {"a"});
    foreach my $key (@$keys) {
        if (length ($key) == 6) {
            my $count = 0;
            foreach my $char (@desired_chars) {
                if($key =~ m/$char/) {
                    $count++;
                }
            }
            if ($count == 5) {
                $encoded -> {"9"} = $key;
                return 1;
            }
        }
    }
}
sub FindG {
    my ($keys, $decrypter) = @_;
    my @desired_chars = split ("", $encoded -> {"9"});
    my $target_chars = $encoded -> {"4"};
    $target_chars .= $decrypter -> {"a"};
    foreach my $char (@desired_chars) {
        unless ($target_chars =~ m/$char/) {
            return $char;                                                                           
        }
    }
}
sub FindE {
    my ($keys, $decrypter) = @_;
    my @desired_chars = split ("", $encoded -> {"8"});
    my $target_chars = $encoded -> {"9"};
    foreach my $char (@desired_chars) {
        unless ($target_chars =~ m/$char/) {
            return $char;                                                                           
        }
    }
}
sub FindZero {
    my ($keys, $decrypter) = @_;
    my @desired_chars = split ("", $encoded -> {"7"});
    push (@desired_chars, $decrypter -> {"g"});
    push (@desired_chars, $decrypter -> {"e"});
    foreach my $key (@$keys) {
        if (length ($key) == 6) {
            my $count = 0;
            foreach my $char (@desired_chars) {
                if($key =~ m/$char/) {
                    $count++;
                }
            }
            if ($count == 5) {
                $encoded -> {"0"} = $key;
                return 1;
            }
        }
    }
}
sub FindB {
    my ($keys, $decrypter) = @_;
    my @desired_chars = split ("", $encoded -> {"0"});
    my $target_chars = $encoded -> {"7"};
    $target_chars .= $decrypter -> {"g"};
    $target_chars .= $decrypter -> {"e"};    
    foreach my $char (@desired_chars) {
        unless ($target_chars =~ m/$char/) {
            return $char;
        }
    }
}
sub FindD {
    my ($keys, $decrypter) = @_;
    my @desired_chars = split ("", $encoded -> {"8"});
    foreach my $char (@desired_chars) {
        unless ($encoded -> {"0"} =~ m/$char/) {
            return $char;
        }
    }
}
sub FindSix {
    my ($keys, $decrypter) = @_;
    my @desired_chars = $decrypter -> {"a"};
    push (@desired_chars, $decrypter -> {"d"});    
    push (@desired_chars, $decrypter -> {"g"});
    push (@desired_chars, $decrypter -> {"e"});
    foreach my $key (@$keys) {
        if (length ($key) == 6) {
            my $count = 0;
            foreach my $char (@desired_chars) {
                if($key =~ m/$char/) {
                    $count++;
                }
            }
            if ($count == 4) {
                $encoded -> {"6"} = $key;
                return 1;
            }
        }
    }
}

sub FindC {
    my ($keys, $decrypter) = @_;
    my @desired_chars = split ("", $encoded -> {"8"});
    foreach my $char (@desired_chars) {
        unless ($encoded -> {"6"} =~ m/$char/) {
            return $char;
        }
    }
}
sub FindF {
    my ($keys, $decrypter) = @_;
    my @desired_chars = split ("", $encoded -> {"1"});
    foreach my $char (@desired_chars) {
        unless ($decrypter -> {"c"} =~ m/$char/) {
            return $char;
        }
    }
}
sub FindTwo {
    my ($keys, $decrypter) = @_;
    my @desired_chars = $decrypter -> {"a"};
    push (@desired_chars, $decrypter -> {"c"});
    push (@desired_chars, $decrypter -> {"d"});
    push (@desired_chars, $decrypter -> {"e"});
    push (@desired_chars, $decrypter -> {"g"});
    foreach my $key (@$keys) {
        if (length ($key) == 5) {
            my $count = 0;
            foreach my $char (@desired_chars) {
                if($key =~ m/$char/) {
                    $count++;
                }
            }
            if ($count == 5) {
                $encoded -> {"2"} = $key;
                return 1;
            }
        }
    }
}
sub FindThree {
    my ($keys, $decrypter) = @_;
    my @desired_chars = $decrypter -> {"a"};
    push (@desired_chars, $decrypter -> {"c"});
    push (@desired_chars, $decrypter -> {"d"});
    push (@desired_chars, $decrypter -> {"f"});
    push (@desired_chars, $decrypter -> {"g"});
    foreach my $key (@$keys) {
        if (length ($key) == 5) {
            my $count = 0;
            foreach my $char (@desired_chars) {
                if($key =~ m/$char/) {
                    $count++;
                }
            }
            if ($count == 5) {
                $encoded -> {"3"} = $key;
                return 1;
            }
        }
    }
}
sub FindFive {
    my ($keys, $decrypter) = @_;
    my @desired_chars = $decrypter -> {"a"};
    push (@desired_chars, $decrypter -> {"b"});
    push (@desired_chars, $decrypter -> {"d"});
    push (@desired_chars, $decrypter -> {"f"});
    push (@desired_chars, $decrypter -> {"g"});
    foreach my $key (@$keys) {
        if (length ($key) == 5) {
            my $count = 0;
            foreach my $char (@desired_chars) {
                if($key =~ m/$char/) {
                    $count++;
                }
            }
            if ($count == 5) {
                $encoded -> {"5"} = $key;
                return 1;
            }
        }
    }
}
sub Decode {
    my $vals = shift;
    my @vals = split (/\s+/, $vals);  
    my $digits;
    
    print Dumper ($encoded), "\n";
    #Oops - test value lcd sections can be in different order than encryption keys. Hack
    VAL:foreach my $val (@vals) {
        my @val_arr = sort (split "", $val);
        KEY:foreach my $key (keys %$encoded) {
            my @target_arr = sort (split "", $encoded -> {$key});
            unless (@val_arr == @target_arr) {
                next;
            }
            for (my $i = 0; $i < @val_arr; $i++) {
                unless ($val_arr[$i] eq $target_arr[$i]) {
                    next KEY;
                }
            }
            $digits .= $key;
            print "$val = ", $encoded -> {$key}, " : $key\n";
        }
    }
    print "$digits\n";
    return $digits;
}
        
        