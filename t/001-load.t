# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 001-load.t'

#########################

use FindBin qw($Bin);
use Test::More tests => 2;
BEGIN { 
        use lib ("$Bin/../../..", "$Bin/../lib/perl", "$Bin/../t/lib"); 
        use_ok('Text::Capitalize');
        use_ok('__title_tests');
       };

#########################


