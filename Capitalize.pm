package Text::Capitalize;

require 5.000;

use strict;
use Exporter;
use vars qw(@ISA @EXPORT $VERSION);

@ISA		= qw(Exporter);
@EXPORT		= qw(capitalize);
$VERSION	= '0.1';

sub capitalize {
   local $_ = shift;
   s/\b(.*?)\b/$1 eq uc $1 ? $1 : "\u\L$1"/ge;
   return $_;
}

1;
__END__


=head1 NAME

Text::Capitalize - capitalize strings ("uGly STrIngS" becomes "Cool Strings")

=head1 SYNOPSIS

   use Text::Capitalize;
   print &capitalize ("...and justice for all"), "\n";
   print &capitalize ("kill 'em all"), "\n";

=head1 DESCRIPTION

Provides B<title-like> formatting for strings. Originally created to put pretty
looking names to MP3 files (first-letter-uppercase). B<Title-like> formatting
consists in converting strings to lowercase and then uppercase first letters
of each word.

Examples of title formatting:

=over 4

=item 'overkill' becomes 'Overkill'

=item 'KiLLiNG TiMe' becomes 'Killing Time'

=back


=head1 USAGE

B<Text::Capitalize> provides only one sub-routine to process strings:

=over 4

=item capitalize (B<string>): returns re-formatted B<string>.

=back


=head1 INSTALLATION

Just execute:

   perl Makefile.PL
   make

And, as root (su):

   make install

=head1 VERSION

Version 0.1

=head1 AUTHOR

   Stanislaw Y. Pusep
      E-Mail:	stanis@linuxmail.org
      ICQ UIN:	11979567
      Homepage:	http://sysdlabs.hypermart.net/

=head1 COPYRIGHT

Copyright (c) 1997-2002 by Stas. All rights reserved.
This program is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut
