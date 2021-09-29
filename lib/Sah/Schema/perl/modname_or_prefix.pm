package Sah::Schema::perl::modname_or_prefix;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Perl module name (e.g. Foo::Bar) or prefix (e.g. Foo::Bar::)',
    description => <<'_',

Contains coercion rule so inputing `Foo-Bar` or `Foo/Bar` will be normalized to
`Foo::Bar` while inputing `Foo-Bar-` or `Foo/Bar/` will be normalized to
`Foo::Bar::`

See also: `perl::modname` and `perl::modprefix`.

_
    match => '\A[A-Za-z_][A-Za-z_0-9]*(::[A-Za-z_0-9]+)*(?:::)?\z',

    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_modname_or_prefix',
    ],

    # provide a default completion which is from list of installed perl modules
    'x.completion' => 'perl_modname_or_prefix',

    examples => [
        {value=>'', valid=>0},
        {value=>'Foo::Bar', valid=>1},
        {value=>'Foo::Bar::', valid=>1},
        {value=>'Foo/Bar', valid=>1, validated_value=>'Foo::Bar'},
        {value=>'Foo/Bar/', valid=>1, validated_value=>'Foo::Bar::'},
        {value=>'Foo-Bar', valid=>1, validated_value=>'Foo::Bar'},
        {value=>'Foo-Bar-', valid=>1, validated_value=>'Foo::Bar::'},
        {value=>'Foo|Bar', valid=>0},
    ],

}];

1;
# ABSTRACT:
