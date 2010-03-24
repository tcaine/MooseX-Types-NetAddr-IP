package MooseX::Types::NetAddr::IP;

use strict;
use warnings;

our $VERSION = '0.01';

use NetAddr::IP ();
use Data::Dumper;

use MooseX::Types::Moose qw/Str ArrayRef/;

use namespace::clean;

use MooseX::Types -declare => [qw( NetAddrIP )];

class_type 'NetAddr::IP';

subtype NetAddrIP, as 'NetAddr::IP';

coerce NetAddrIP, 
    from Str, 
    via { 
        'NetAddr::IP'->new( $_ ) 
            or die "Cannot coerce '$_' into a NetAddr::IP object.\n";
    };

coerce NetAddrIP, 
    from ArrayRef[Str], 
    via { 
        'NetAddr::IP'->new( @$_ ) 
            or die "Cannot coerce '@$_' into a NetAddr::IP object.\n";
    };

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

MooseX::Types::NetAddr::IP - Perl extension for blah blah blah

=head1 SYNOPSIS

  use MooseX::Types::NetAddr::IP;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for MooseX::Types::NetAddr::IP, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

root, E<lt>root@frontiernet.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by root

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
