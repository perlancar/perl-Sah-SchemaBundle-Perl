package Data::Sah::Value::perl::Perl::these_mods;

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
        summary => '"these" Perl module names',
        description => <<'_',

See <pm:App::ThisDist>'s `this_mod()` for more details on how "this module" is
determined. Currently this rule returns a 1-element arrayref containing "this
module". Note that currently `App::ThisDist` is not automatically added as
prerequisite.

_
        prio => 50,
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
        'do { if (eval { require App::ThisDist; 1 }) { my $thismod = App::ThisDist::this_mod(); defined $thismod ? [$thismod] : undef } else { undef } }',
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|value)$

=head1 DESCRIPTION
