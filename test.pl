# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..5\n"; }
END {print "not ok 1\n" unless $loaded;}
use Attribute::Abstract;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

sub nothere : Abstract;

eval { nothere() };
print "not " unless $@ =~ /call to abstract method/;
print "ok 2\n";

my $obj = MyObj->new;
eval { $obj->somesub() };
print "not " unless $@ =~ /call to abstract method/;
print "ok 3\n";

my $obj2 = MyObj::Better->new;
eval { $obj2->somesub() };
print "not " if $@ =~ /call to abstract method/;
print "ok 4\n";

# rebless to make somesub() work
bless $obj, 'MyObj::Better';
eval { $obj->somesub() };
print "not " if $@ =~ /call to abstract method/;
print "ok 5\n";

package MyObj;
sub new { bless {}, shift }
sub somesub: Abstract;

package MyObj::Better;
use base 'MyObj';
sub somesub { return "I'm implemented!" }
