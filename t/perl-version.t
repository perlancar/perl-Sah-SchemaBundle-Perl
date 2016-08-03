#!perl

use 5.010001;
use strict;
use warnings;

use Test::Exception;
use Test::More 0.98;
use Test::Needs;

subtest "coercion" => sub {
    test_needs 'Data::Sah::Coerce';

    my $c = Data::Sah::Coerce::gen_coercer(
        type=>"obj", coerce_rules => ['str_perl_version']);

    is_deeply($c->([]), [], "uncoerced");
    dies_ok { $c->("*") };
    ok($c->("1.2.0") == version->parse("1.2.00"));
};

done_testing;
