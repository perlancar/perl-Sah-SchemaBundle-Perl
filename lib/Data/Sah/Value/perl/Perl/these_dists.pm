package Data::Sah::Value::perl::Perl::these_dists;

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
        summary => '"these" Perl distribution names',
        description => <<'_',

See <pm:App::ThisDist>'s `this_dist()` for more details on how "this
distribution" is determined. Currently this returns a 1-element arrayref
containing "this distribution". Note that currently `App::ThisDist` is not
automatically added as prerequisite.

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
        'do { if (eval { require App::ThisDist; 1 }) { my $thisdist = App::ThisDist::this_dist(); defined $thisdist ? [$thisdist] : undef } else { undef } }',
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|value)$

=head1 DESCRIPTION
