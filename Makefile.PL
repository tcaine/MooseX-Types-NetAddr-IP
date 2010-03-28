
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'MooseX::Types::NetAddr::IP',
    VERSION_FROM      => 'lib/MooseX/Types/NetAddr/IP.pm', # finds $VERSION
    PREREQ_PM         => {
        'MooseX::Types'         => 0,
        'MooseX::Types::Moose'  => 0,
        'namespace::clean'      => 0,
        'NetAddr::IP'           => 0,
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (AUTHOR         => 'Todd Caine <todd.caine@gmail.com>') : ()),
);
