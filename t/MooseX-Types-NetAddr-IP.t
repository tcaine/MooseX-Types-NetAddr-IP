
use strict;
use warnings;

use Test::More tests => 3;
use Moose::Util::TypeConstraints;

use_ok 'MooseX::Types::NetAddr::IP';

isa_ok find_type_constraint('NetAddr::IP'), 'Moose::Meta::TypeConstraint';

{
    package MyCoercionTest;

    use Moose;
    use MooseX::Types::NetAddr::IP qw( NetAddrIP );

    has 'address' => ( is => 'rw', isa => NetAddrIP, coerce => 1 );
}

my $obj = MyCoercionTest->new({address => '127.0.0.1/32'});
my $ip = $obj->address;

isa_ok $ip, "NetAddr::IP", "coerced from string";


1;
