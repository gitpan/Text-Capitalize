# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 002-capitalize_title-default.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More;
BEGIN { use_ok('Text::Capitalize') };

use FindBin qw($Bin);
use lib ("$Bin/../lib/perl", "$Bin/../t/lib"); 
use Text::Capitalize 0.2 qw(capitalize_title);
use __title_tests qw(%expect_capitalize_title_PRESERVE_ALLCAPS_PRESERVE_WHITESPACE); 

plan tests => scalar keys %expect_capitalize_title_PRESERVE_ALLCAPS_PRESERVE_WHITESPACE;
            
#########################

foreach $in (keys %expect_capitalize_title_PRESERVE_ALLCAPS_PRESERVE_WHITESPACE) { 
   $out = $expect_capitalize_title_PRESERVE_ALLCAPS_PRESERVE_WHITESPACE{$in};
   is (capitalize_title($in, 
                        PRESERVE_ALLCAPS => 1,
                        PRESERVE_WHITESPACE => 1), $out, "test: $in");
}
