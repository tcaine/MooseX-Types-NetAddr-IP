package MooseX::Types::NetAddr::IP;

use strict;
use warnings;

our $VERSION = '0.01';

use NetAddr::IP ();
use MooseX::Types::Moose qw/Str ArrayRef/;
use namespace::clean;

use MooseX::Types -declare => [qw( NetAddrIP NetAddrIPv4 NetAddrIPv6 )];

class_type 'NetAddr::IP';

subtype NetAddrIP,   as 'NetAddr::IP';
subtype NetAddrIPv4, as 'NetAddr::IP';
subtype NetAddrIPv6, as 'NetAddr::IP';

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

my $ipv4prefix = '(?:[1-2]?[0-9]|3[0-2])';
my $ipv4unit   = '(?:25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})';
my $ipv4       = "(?:$ipv4unit\.){3}$ipv4unit";

coerce NetAddrIPv4,
    from Str,
    via {
        die "'$_' is not a valid IPv4 address." 
            unless m/^$ipv4(?:\/$ipv4prefix)?$/;

        'NetAddr::IP'->new( $_ )
            or die "Cannot coerce '$_' into a NetAddr::IP object.\n";
    };

my $ipv6prefix = '(?:[1-9]?[0-9]|1[0-2][0-9]|12[0-8])';
my $ipv6unit   = '[0-9a-fA-F]{0,4}';
my $ipv6       = "(?:(?:$ipv6unit:){2,7}$ipv6unit)|::[fF]{4}:$ipv4";

coerce NetAddrIPv6,
    from Str,
    via { 
        die "'$_' is not a valid IPv6 address."
            unless m/^$ipv6(?:\/$ipv6prefix)?$/;

        'NetAddr::IP'->new( $_ )
            or die "Cannot coerce '$_' into a NetAddr::IP object.\n";
    };

1;
__END__

=head1 NAME

MooseX::Types::NetAddr::IP - NetAddr::IP related types and coercions for Moose

=head1 SYNOPSIS

  use MooseX::Types::NetAddr::IP qw( NetAddrIP NetAddrIPv4 NetAddrIPv6 );

=head1 DESCRIPTION

This package provides internet address types for Moose.

=head2 TYPES

NetAddrIP

    Coerces from Str and ArrayRef[Str,Str] via "new" in NetAddr::IP. 

NetAddrIPv4

    Coerces from Str via "new" in NetAddr::IP.

NetAddrIPv6

    Coerces from Str via "new" in NetAddr::IP.

=head1 SEE ALSO

L<NetAddr::IP>

=head1 AUTHOR

Todd Caine, E<lt>todd.caine@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Todd Caine

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
