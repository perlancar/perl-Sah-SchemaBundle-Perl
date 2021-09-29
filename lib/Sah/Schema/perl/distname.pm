package Sah::Schema::perl::distname;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Perl distribution name, e.g. Foo-Bar',
    match => '\A[A-Za-z_][A-Za-z_0-9]*(-[A-Za-z_0-9]+)*\z',
    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_distname',
    ],

    # provide a default completion which is from list of installed perl distributions
    'x.completion' => 'perl_distname',

    description => <<'_',

For convenience (particularly in CLI with tab completion), you can input one of:

    Foo::Bar
    Foo/Bar
    Foo/Bar.pm
    Foo.Bar

and it will be coerced into Foo-Bar form.

_
}];

1;
# ABSTRACT:
