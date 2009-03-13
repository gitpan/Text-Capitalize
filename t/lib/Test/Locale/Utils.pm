package Test::Locale::Utils;
#                                doom@kzsu.stanford.edu
#                                29 Jan 2006

=head1 NAME

Test::Locale::Utils - utilities for writing tests involving international characters

=head1 SYNOPSIS

### TODO revise

   use Test::More;
   use Test::Locale::Utils qw(:all);
   my @exchars = extract_extended_chars(\@strings);
   my $internat = internationalized_locale(@exchars);
   my $exchars_str = join '', @exchars;
   my $exchars_rule = qr{[$exchars_str]};

   foreach my $string (@strings) {
      SKIP: {
         skip "This locale can't deal with i18n chars in string: $string", 1,
             unless ($internat && ($string =~ /$exchars_rule/) );

         is( $expected{$string}, string_transformation($string), "Testing $string" );
      }
   }

=head1 DESCRIPTION

A small collection of utility functions to make it easier to
write tests that work with strings that may contain characters
beyond the 7bit ASCII range (e.g. the "extended characters" or
"international characters" of iso9959-1 and friends).

=head1 EXPORTED

Nothing by default.  All of the following are exportable
on request (and all may be requested with the ":all" tag).

=over

=cut

use 5.006;
use strict;
use warnings;
use Carp;
use Data::Dumper;
use List::MoreUtils qw( all );

my $DEBUG = 0;

require Exporter;

our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw(
  extract_extended_chars
  internationalized_locale
  is_locale_international
  define_sample_i18n_chars
) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(  );

our $VERSION = '0.01';

=item extract_extended_chars

Given a reference to an array of strings, returns a list of all
extended characters that have appeared at least once in the
strings.

=cut

sub extract_extended_chars  {
    my $aref = shift;

    my $sevenbit_rule = qr{[\x00-\x7F]};

    my %seen;
    foreach my $string ( @{$aref} ) {
      (my $residue = $string) =~ s/$sevenbit_rule//g;
      my @chars = split //, $residue;
      @seen{@chars} = (); # mark these chars as seen by filling hash with "undef" values
    }
    my @exchars = sort keys %seen;
    return @exchars;
}

=item  internationalized_locale

DEPRECATED.

Given an array of extended characters that you care about,
this code will check to make sure that the current locale
seems to comprehend what to do with them.  Specifically,
it checks to see if they have a defined upper and lower case.

This is an excessively simple version that just looks at the
extended characters to see if they change case when run through
either uc or lc.

This apparently fails for some locales, e.g. Russian, where the
extended chars are in the same locations as in iso8859, but the
upper and lower have reversed positions.

=cut

sub internationalized_locale {
  my @exchars = @_;
  use locale;

  my $okay = 1;
  foreach my $ex (@exchars) {
    my $up = uc($ex);
    my $down = lc($ex);
    if ($up eq $down) { # then we got problems
      warn "For this locale, uppercase and lowercase not defined for $ex\n" if $DEBUG;
      $okay = 0;
    }
  }
  return $okay;
}


=item  is_locale_international

Looks at the behavior of uc and lc with a small sample of
international characters: this just checks if the "extended
characters" of latin-1 and friends have an upper and lower form
defined as expected.

=cut

sub is_locale_international {
  my $exchars = define_sample_i18n_chars();
  use locale;

  my @checks;
  foreach my $pair ( @{ $exchars } ) {
    my $lower = $pair->[0];
    my $upper = $pair->[1];

    my $new_up   = uc($lower);
    my $new_down = lc($upper);

    if ( ($upper eq $new_up)   &&
         ($lower eq $new_down) ) { # transformed as expected
      push @checks, 1;
    } else {
      push @checks, 0;
    }
  }
  print STDERR "internationalized_locale: char status: ",
    join " ", @checks, "\n" if ($DEBUG) ;
  my $okay = all { ($_) } @checks;
  return $okay;
}


=item define_sample_i18n_chars

Returns a short list of pairs of extended characters,
pairing a lowercase form with an uppercase one
(an aref of arefs).

=cut

sub define_sample_i18n_chars {

  my @exchars = (
                ['�', '�'],
                ['�', '�'],
                ['�', '�'],
                ['�', '�'],
              );

  return \@exchars;
}













1;
__END__

=back

=head1 DISCUSSION

The "use locale" story seems to have some notable gaps.
A brief summary, off the top of my head:

There's no definitive way to get a listing of all available
locales on a system.  The right way to do it varies from platform
to platform.  There's no definitive way of finding out what
platform you're on: You can check ^O, but you need to parse it
yourself (and obvious tricks you might use like matching for
/win/ to see if you're on a windows platform will get confused in
cases like "cygwin").  There's no definitive list of all possible
values of ^O (or if there is, I have not been able to discover
it).  There are some useful tricks in the POSIX module that can
help with these issues, but you can't count on every system that
perl runs on being POSIX compliant, (and like I just said,
checking what kind of platform you're on is a little trickier
than you'd think).

This little module is an attempt at cutting the Gordian Knot
represented by this cluster of problems, at least
as far as the automated tests for Text::Capitalize are concerned.

Since it's difficult to determine the Right Way to do
cross-platform checks of string handling including international
characters, instead I use some simple operational tests to see if
the system does what's expected with the international
characters, and if not, the tests using those characters
will be skipped.

=head1 SEE ALSO

L<perlocale>

=head1 AUTHOR

Joseph Brenner, E<lt>doom@kzsu.stanford.eduE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Joseph Brenner

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=head1 BUGS

None reported... yet.

=cut
