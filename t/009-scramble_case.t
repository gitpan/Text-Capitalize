# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 009-scramble_case.t'

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

use Text::Capitalize 0.4 qw(scramble_case);
use __title_tests qw(%expect_scramble_case); 

use Test::Locale::Utils qw(:all);

my @test_cases = keys %expect_scramble_case;
my @exchars = extract_extended_chars(\@test_cases);
my $i18n = internationalized_locale(@exchars);
my $exchars_str = join '', @exchars;
my $exchars_rule = qr{[$exchars_str]};

plan tests => scalar( keys( %expect_scramble_case ) ) + 1;
            
#########################

{
  # seeding with a known value, should get repeatable sequence from rand
  srand(666);
  # Also need to sort the test cases, to get the same order that 
  # was used in generating the answer key.  

  my ($in, $out, $out_expected);
  #  open my $tfh, ">", "/home/doom/End/Cave/CapitalizeTitle/tmp/tempoutput-randomcase.$$" or die $!;
  foreach $in (sort keys %expect_scramble_case) { # must sort for same order as original test generation
  SKIP: {
      skip "This locale can't deal with i18n chars in string: $in", 1, 
        if (
            ($in =~ /$exchars_rule/) && 
            not $i18n 
           );

      $out_expected = $expect_scramble_case{$in};
      $out = scramble_case($in);

      #    $in =~ s/'/\\'/g;
      #    $out =~ s/'/\\'/g;
      #    print $tfh "     '$in' =>\n        '$out',\n";

      is ($out, $out_expected, "test: $in");
    }
  }
}

# Weirdly enough, I had to use the code commented out above as 
# a test case generator.  Trying to do the same thing in a 
# separate script didn't work... something odd going on with 
# the srand method of getting a repeatable sequence out of rand? 

# Regression test: make sure $_ isn't munged by unlocalized use
{ 
  my $anything = "Whirl and Pieces";
  my $keeper = "abc123";
  local $_ = $keeper;
  scramble_case($anything);
  is ($_, $keeper, "\$\_ unaffected by capitalize_title");
}

