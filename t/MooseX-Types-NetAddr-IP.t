
use strict;
use warnings;

use Test::More tests => 5;
use Moose::Util::TypeConstraints;

use_ok 'MooseX::Types::NetAddr::IP';

isa_ok find_type_constraint('NetAddr::IP'), 'Moose::Meta::TypeConstraint';

{
    package MyCoercionTest;

    use Moose;
    use MooseX::Types::NetAddr::IP qw( NetAddrIP );

    has 'address' => ( is => 'rw', isa => NetAddrIP, coerce => 1 );
}

my $ip = MyCoercionTest->new({address => '127.0.0.1/32'})->address;
isa_ok $ip, "NetAddr::IP", "coerced from string";

$ip = MyCoercionTest->new({address => ['10.0.0.255', '255.0.0.0']})->address;
isa_ok $ip, "NetAddr::IP", "coerced from string";

eval { my $obj = MyCoercionTest->new({address => '343.0.0.1/320'}); };
ok $@, 'invalid IP address';

1;
