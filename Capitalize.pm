package Text::Capitalize;

use 5.004;
use strict;

use locale;
use Carp;
use Exporter;
use vars qw(@ISA @EXPORT @EXPORT_OK $VERSION);

@ISA		= qw(Exporter);
@EXPORT		= qw(capitalize capitalize_title);
@EXPORT_OK      = qw(@exceptions %defaults_capitalize_title); 
$VERSION	= '0.2';

# Define the pattern to match "exceptions": the minor words 
# that don't usually get capitalized in titles (used by capitalize_title)
use vars qw(@exceptions);
@exceptions = qw(
     a an the 
     and or nor for but so yet 
     to of by at for but in with has
     de von
     s re t d
  );

# Define the default arguments for the capitalize_title function
use vars qw(%defaults_capitalize_title);
%defaults_capitalize_title = (
             PRESERVE_WHITESPACE => 0,
             PRESERVE_ALLCAPS    => 0,
             PRESERVE_ANYCAPS    => 0,
             NOT_CAPITALIZED     => \@exceptions,
            );


sub capitalize {
   local $_ = shift;
   s/\b(.*?)\b/$1 eq uc $1 ? $1 : "\u\L$1"/ge; 
   return $_;
}

sub capitalize_title { 

  my ($keep_ws, $keep_acronyms, $keep_mixups, $leading_whitespace, 
      $string, $sentence, $word, $spc, $punct1, $punct2);
  my ($new_string, $new_sent,  $except_rule);

  $string = shift;

  my %args = (%defaults_capitalize_title,
              @_   # imports the argument pair list, if any
              );

  # Checking for spelling errors in input options 
  # (locked hashes are still too new for me).
  foreach (keys %args) { 
    unless (exists $defaults_capitalize_title{$_}) { 
      carp "Bad option $_\n";
    }
  }

  $keep_ws =       $args{PRESERVE_WHITESPACE};
  $keep_acronyms = $args{PRESERVE_ALLCAPS};
  $keep_mixups =   $args{PRESERVE_ANYCAPS};

  my $exceptions_or = join '|', @{ $args{NOT_CAPITALIZED} };
  $except_rule = qr/^(?:$exceptions_or)$/oi;  

  $new_string = "";

  # For each sentence in the string
  # (titles *can* have multiple sentences -- especially
  # since I'm calling ":" a sentence delimeter...)

  while ( $string =~ m{(.*?)                    # anything up to... 
                       (\.\.\.|\.|\?|!|--|:|$)  # any sentence terminator, or eos
                       (\s*)                    # trailing whitespace, if any
                      }gx ) {                                                        

    $sentence = $1 . $2;
    $sentence .= $3 if defined $3;
    $new_sent = ""; 

    # process the sentence by words, save ancilliary characters
    while ( $sentence =~ m{ ([^\w\s]*)  # $1 capture leading punctuation 
                                        #   (e.g. ellipsis, apostrophe)
                            (\w*)       # $2 capture the word 
                            ([^\w\s]*)  # $3 capture trailing punctuation 
                                        #   (e.g. comma, ellipsis, period)
                            (\s*)       # $4 capture trailing whitespace 
                                        #   (usually " ", though at EOL prob "")
                           }gx ) {                                                   

      # collapse the whitespace to one space, unless we need to preserve it
      $spc = "";
      if ($keep_ws) { 
        $spc = $4;
      } else { 
        $spc = " " unless ($4 eq ""); 
      }

      # always preserve leading or trailing punctuation 
      #   (e.g. "...and", "'em", "and...", "F.B.I.")
      $punct1 = $1;             # leading
      $punct2 = $3;             # trailing

      $_ = $2;                  # the current word

      # Check for a word with *any* capitals ("iMac, NeXt, Boom, BOOM"), 
      # when they're being passed through untouched.
      if ( ($keep_mixups) && ( /[[:upper:]]/ ) ) {  
        $new_sent .=  $punct1 . $_ . $punct2 . $spc;
        next;
      }

      # Check for an all uppercase word, but only
      # when they're being passed through as acronyms.
      if ( ($keep_acronyms) && ( $_ eq uc $_ ) ) {  
        $new_sent .=  $punct1 . $_ . $punct2 . $spc;
        next;
      }

      # Words on the exception list are lowercase, all others are upper-cased...
      if ( /$except_rule/ ) {
        $_ = lc;
      } else {
        $_ = ucfirst( lc );
      }

      # Single-character initialisms may also be 
      # on the exception list, e.g. in "forget gilroy, A. Snakhausem was here" 
      # the a should be upcased.  Similarly with 
      # the "a" in "N.A.S.A." (otherwise you'd get: "N.a.S.a.")
      if (length($_) == 1 && ($punct2 eq ".")) {  
        $_ = uc;
      }

      $new_sent .=  $punct1 . $_ . $punct2 . $spc;
    }  # end of per word loop

    # Fix-ups to handle the first word and the last, 
    # which are capitalized even if they're on the 
    # exception list

    $new_sent =~   s{ ^(\W*)(\w) }    
                    { $1 . uc($2) }ex;        # First word 
                                              # (ignores leading "..." and so on)        
    $new_sent =~   s{ (\W)(\w+\W*)$ }  
                    { $1 . ucfirst($2) }ex;   # Last word                               

    $new_string .= $new_sent;

  } # end of per sentence loop.

  # If we're not preserving whitespace, 
  # get rid of the leading or trailing spaces.
  unless ($keep_ws) { 
    $new_string =~ s|^\s+||; 
    $new_string =~ s|\s+$||; 
  }

  return $new_string;

}

1;

__END__

=head1 NAME

Text::Capitalize - capitalize strings ("to WORK AS titles" becomes "To Work as Titles")

=head1 SYNOPSIS

   use Text::Capitalize;

   print capitalize("...and justice for all"), "\n";
      ...And Justice For All

   print capitalize_title("...and justice for all"), "\n";
      ...And Justice for All

   print capitalize_title("agent of SFPUG", PRESERVE_ALLCAPS=>1 ), "\n";
      Agent of SFPUG

   print capitalize_title("the ring:  symbol or cliche?", PRESERVE_WHITESPACE=>1 ), "\n";
      The Ring:  Symbol or Cliche?
      (Note, double-space after colon is still there.)

=head1 ABSTRACT

  Text::Capitalize is for capitalizing strings in a manner 
suitable for use in titles. 

=head1 DESCRIPTION

Text::Capitalize provides a few different flavors of procedures
for B<title-like> formatting for strings.

For the "capitalize" function (originally created to put
pretty looking names to MP3 files) B<Title-like> formatting
consists of ensuring that the first letter of each word is
uppercase, and that the rest is lowercase.

The "capitalize_title" function tries to get closer to 
English title capitalization rules (discussed below) where 
only the "important" words are supposed to be capitalized.
There are also some customization features provided to allow 
the user to choose variant rules.

Examples of title formatting with "capitalize":

=over

=item 'overkill' becomes 'Overkill'

=item 'KiLLiNG TiMe' becomes 'Killing Time'

=back


Some simple examples of title formatting with "capitalize_title":

=over 

=item 'we have come to wound the autumnal city' becomes 'We Have Come to Wound the Autumnal City'

=item 'ask not for whom they ask not' becomes 'Ask not for Whom They Ask Not'

=back

=head1 BACKGROUND

The capitalize_title function makes an attempt at doing the
right thing by default.  The goal is to take an arbitrary
chunk of text and adjust it automatically so that it can
be used as a title... But as with many aspects of the human
languages, it is extremely difficult to come up with a set
of programmatic rules that will cover all cases.  

=head2 Words that don't get capitalized

This web page:

  http://www.continentallocating.com/World.Literature/General2/LiteraryTitles2.htm

presents some admirably clear rules for capitalizing titles:

  ALL words in EVERY title are capitalized except

  (1) a, an, and the,

  (2) two and three letter conjunctions (and, or, nor, for, but, so, yet), 

  (3) prepositions.  

  Exceptions:  The first and last words are always capitalized even 
  if they are among the above three groups.

But consider the case:

  "It Waits Underneath the Sea"

Should the word "underneath" be downcased because it's a preposition? 
Most English speakers would be surprised to see it that way.
Consequently, the default exception to capitalization list in this module 
only includes the shortest of the common prepositions (to of by at for but in).  

The default entries on the exception list are:

=over

     a an the 
     and or nor for but so yet 
     to of by at for but in with has
     de von
     s re t d

=back

The observant may note that the last rows are not
composed of English words.  The honorary "de" has been 
included solely in honor of "Honore de Balzac". While 
I was at it, I added "von" for the sake of equal time.

The very last row is not composed of words at all: these are
fragments to facilitate handling cases like "it's",
"they're", "isn't" and "you'd".  Otherwise, as written, this
program would behave as though the fragment after the
apostrophe was a separate word, and "Hell's" would become
"Hell'S".

Note: future versions may attempt to treat an apostrophe as
a word character instead, in which case, the last row would
be removed from the default exception list.  But that approach 
would have it's own difficulties, involving disambiguating
single quotes.

=head2 Customizing the Exceptions to Capitalization

If you have different ideas about the "rules" of English
(or if you're trying to use this code with another language
with different rules) you might like to substitute a new
exception list of your own:

    print capitalize_title("Dude, we, like, went to Old Slavy, and uh, they didn't have it",
                           NOT_CAPITALIZED => [qw(uh duh huh wha like man you know)]);

    This should output:
        Dude, We, like, Went To Old Slavy, And uh, They Didn'T Have It
    (Note the problem with "Didn'T", caused by omitting the group of suffixes: "s re t d")


Less radically, you might like to simply add a word to the list,
for example "from":

    use Text::Capitalize 0.2 qw(capitalize_title @exceptions);
    push @exceptions, "from";

    print capitalize_title("fungi from yuggoth", 
                           NOT_CAPITALIZED => \@exceptions);

    This should output:
        Fungi from Yuggoth

=head2 All Uppercase Words

In order to work with a wide range of input strings, by default
capitalize_title presumes that upper-case input needs to be adjusted
(e.g. "DOOM APPROACHES!" would become "Doom Approaches!").  But, this doesn't 
allow for the possibility of an acronym in a title (e.g. "RAM Prices Plummet" 
ideally should not become "Ram Prices Plummet").  If the PRESERVE_ALLCAPS 
option is set, then it will be presumed that an all-uppercase word is that 
way for a reason, and will be left alone:

   print capitalize_title("ram more RAM down your throat", 
                       PRESERVE_ALLCAPS => 1);

   Ram More RAM Down Your Throat

=head2 Preserving Any Usage of Uppercase for Mixed-case Words

There are some other odd cases that cannot be handled well by the default 
settings, notably mixed-case words such as "iMac", "CHiPs", and so on.
For these purposes, a PRESERVE_ANYCAPS option has been provided which 
presumes that any usage of uppercase is there for a reason, and the 
entire word should be passed through untouched.  With PRESERVE_ANYCAPS 
on, only the case of all lowercase words will ever be adjusted: 


    print capitalize_title("TLAs i have known and loved", 
                       PRESERVE_ANYCAPS => 1);

    TLAs I Have Known and Loved

    print capitalize_title("the next iMac: just another NeXt?", 
                           PRESERVE_ANYCAPS => 1);

    The Next iMac: Just Another NeXt?


=head2 Handling Whitespace

By default, the capitalize_title function presumes that you're trying
to clean up potential title strings. As an extra feature it collapses
multiple spaces and tabs into single spaces.  If this feature doesn't
seem desirable and you want it to literally restrict itself to
adjusting capitalization, you can force that behavior with the
PRESERVE_WHITESPACE option:

    print capitalize_title("it came from texas:  the new new world order?", 
                           PRESERVE_WHITESPACE => 1);

    It Came From Texas:  The New New World Order?
    (Note: the double-space after the colon is still there.)

=head2 Comparison to Text::Autoformat

As you might expect, there's more than one way to do this, 
and these two pieces of code perform very similar functions:

=over

   use Text::Capitalize 0.2;
   print capitalize_title($t), "\n";

   use Text::Autoformat;
   print autoformat{case => "highlight", right=>length($t)}, $t;

=back

(Note: supplying the length of the string as the "right
margin" is a performance hack: this is much faster than
plugging in an arbitrarily large number.  The "fill" parameter 
doesn't appear to work to turn off line-breaking, but possibly 
it will in the future.)

As of this writing, "capitalize_title" has some advantages:

=over 

=item 1. 

It works on characters outside the English 7-bit ASCII range,
for example with my locale setting the ISO-8859-1 International 
characters are handled correctly, so that "über maus" becomes 
"Über Maus".

=item 2. 

Minor words following leading punctuation become upper case: 

=over

"...And Justice for All"

=back

=item 3. 

It works with multiple sentence input (e.g. "And sooner. And later." 
should probably not be "And sooner. and later.")

=item 4. 

The list of minor words is more extensive (i.e. includes: so, yet, nor),
and is also customizeable.

=item 5. 

There's a method of preserving acronyms via the PRESERVE_ALLCAPS flag
and similarly, mixed-case words ("iMac", "NeXt", etc") with the 
PRESERVE_ANYCAPS flag.

=item 6. 

It's roughly ten times faster.

=back

Another difference is that Text::Autoformat's "highlight"
always preserves whitespace something like capitalize_title 
does with the PRESERVE_WHITESPACE option set.

However, it should be pointed out that Text::Autoformat is under
active maintenance by Damian Conway (and does far more than this 
module does): it's recommended that you look into using it. 


=head1 EXPORT

By default, this version of the module provides the two
functions capitalize and capitalize_title.  Future versions 
will have no further additions to the default export list.

It is also possible to export:

=over

=item 

The list of minor words that capitalize_title uses by default to
determine the exceptions to capitalization: @exceptions.
 
=item 

The hash of allowed arguments (with defaults) that the
capitalize_title function uses: %defaults-capitalize_title.

=back

=head1 BUGS 

  (1) In capitalize_title, quoted sentence terminators are treated 
  as actual sentence breaks, e.g. in this case: 

     'say "yes but!", say "know what?"'

  The program sees the ! and effectively treats this as 
  two separate sentences: the word "but" becomes "But", 
  under the rule that last words must always be
  uppercase, even if they're on the exception list.

  (2) In capitalize_title, a string like: 
  
      "The Next iMac: Just Another NeXt?" 

  Is not handled well, even with the PRESERVE_ANYCAPS 
  flag turned on.  Here, "iMac" is treated as the last 
  word of a sentence and is forcibly capitalized as "IMac".


=head1 SEE ALSO

  Text::Autoformat

=head1 VERSION

Version 0.2

=head1 AUTHORS

   Joseph M. Brenner 
      E-Mail:   doom@kzsu.stanford.edu
      Homepage: http://www.grin.net/~mirthless/

   Stanislaw Y. Pusep
      E-Mail:	stanis@linuxmail.org
      ICQ UIN:	11979567
      Homepage:	http://sysdlabs.hypermart.net/

   (And many thanks to Belden Lyman, for feature 
   suggestions and code examples.)

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Joseph Brenner. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
