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
        return NetAddr::IP->new( $_ ) 
            or die "'$_' is not an IP address.\n";
    };

coerce NetAddrIP, 
    from ArrayRef[Str], 
    via { 
        return NetAddr::IP->new( @$_ ) 
            or die "'@$_' is not an IP address.\n";
    };

coerce NetAddrIPv4,
    from Str,
    via {
        my $this = NetAddr::IP->new( $_ )
            or die "'$_' is not an IPv4 address.\n";

        die "'$_' is not an IPv4 address."
            unless $this->version == 4;

        return $this;
    };

coerce NetAddrIPv4,
    from ArrayRef[Str],
    via {
        my $this = NetAddr::IP->new( @$_ )
            or die "'@$_' is not an IPv4 address.\n";

        die "'@$_' is not an IPv4 address."
            unless $this->version == 4;

        return $this;
    };

coerce NetAddrIPv6,
    from Str,
    via { 
        my $this = NetAddr::IP->new( $_ )
            or die "'$_' is not an IPv6 address.\n";

        die "'$_' is not an IPv6 address.\n"
            unless $this->version == 6;

        return $this
    };

coerce NetAddrIPv6,
    from ArrayRef[Str],
    via { 
        my $this = NetAddr::IP->new( @$_ )
            or die "'@$_' is not an IPv6 address.\n";

        die "'@$_' is not an IPv6 address.\n"
            unless $this->version == 6;

        return $this
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
