# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 002-capitalize_title-default.t'

#########################

use warnings;
use strict;
$|=1;

use Test::More;
use FindBin qw($Bin);
BEGIN { 
  use lib ("$Bin/../../..", "$Bin/../lib/perl", "$Bin/../t/lib"); 
  use_ok('Text::Capitalize') 
};

use Text::Capitalize 0.4 qw(capitalize_title);
use __title_tests qw(%expect_capitalize_title_PRESERVE_ANYCAPS_PRESERVE_WHITESPACE); 

plan tests => scalar keys %expect_capitalize_title_PRESERVE_ANYCAPS_PRESERVE_WHITESPACE;
            
#########################

{
  my ($in, $out_expected);
  foreach $in (keys %expect_capitalize_title_PRESERVE_ANYCAPS_PRESERVE_WHITESPACE) { 
    $out_expected = $expect_capitalize_title_PRESERVE_ANYCAPS_PRESERVE_WHITESPACE{$in};
    is (capitalize_title($in, 
                         PRESERVE_ANYCAPS => 1,
                         PRESERVE_WHITESPACE => 1), $out_expected, "test: $in");
  }
}
