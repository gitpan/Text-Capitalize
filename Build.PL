use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Text::Capitalize',
    license             => 'perl',
    dist_author         => q{Joseph Brenner <doom@kzsu.stanford.edu>},
    dist_version_from   => 'lib/Text/Capitalize.pm',
    build_requires => {
                       'Test::More' => 0,
                       'locale'     => 0,
                       'Carp'       => 1.01,
                       'Exporter'   => 5.562,
                       'FindBin'    => 1.04,
                       'Env'        => 1.00,
                      },
    add_to_cleanup      => [ 'Text-Capitalize-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
