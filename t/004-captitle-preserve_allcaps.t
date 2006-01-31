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
use __title_tests qw(%expect_capitalize_title_PRESERVE_ALLCAPS); 

use Test::Locale::Utils qw(:all);

my @test_cases = keys %expect_capitalize_title_PRESERVE_ALLCAPS;
my @exchars = extract_extended_chars(\@test_cases);
my $i18n = internationalized_locale(@exchars);
my $exchars_str = join '', @exchars;
my $exchars_rule = qr{[$exchars_str]};

plan tests => scalar( keys( %expect_capitalize_title_PRESERVE_ALLCAPS ) ) + 1;
#########################

{
  my ($in, $out_expected);
  foreach $in (keys %expect_capitalize_title_PRESERVE_ALLCAPS) { 
  SKIP: {
      skip "This locale can't deal with i18n chars in string: $in", 1, 
        if (
            ($in =~ /$exchars_rule/) && 
            not $i18n 
           );

      $out_expected = $expect_capitalize_title_PRESERVE_ALLCAPS{$in};
      is (capitalize_title($in, PRESERVE_ALLCAPS => 1), $out_expected, "test: $in");
    }
  }
}

# Regression test: make sure $_ isn't munged by unlocalized use
{ 
  my $anything = "Whirl and Pieces";
  my $keeper = "abc123";
  local $_ = $keeper;
  capitalize_title($anything, PRESERVE_WHITESPACE => 1);
  is ($_, $keeper, "\$\_ unaffected by capitalize_title");
}
