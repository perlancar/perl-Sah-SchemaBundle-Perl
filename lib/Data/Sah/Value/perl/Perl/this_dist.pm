package Data::Sah::Value::perl::Perl::this_dist;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    +{
        v => 1,
        summary => 'Repeat a string a number of times',
        description => <<'_',

See <pm:App::ThisDist>'s `this_mod()` for more details on how "this module" is
determined. Note that currently `App::ThisDist` is not automatically added as
prerequisite.

_
        args => {
            str => {schema=>'str*', req=>1},
            n => {schema=>'uint*', default=>1},
        },
    };
}

sub value {
    my %cargs = @_;

    my $gen_args = $cargs{args} // {};
    my $res = {};

    # $res->{modules}{"App::ThisDist"} //= 0;

    $res->{expr_value} = join(
        '',
        'do { if (eval { require App::ThisDist; 1 }) { App::ThisDist::this_dist() } else { undef } }',
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|value)$

=head1 DESCRIPTION
