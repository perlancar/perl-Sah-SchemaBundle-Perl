package Sah::Schema::perl::modprefix;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Perl module prefix, e.g. Foo::Bar::',
    description => <<'_',

Perl module prefix, e.g. `Foo::Bar::`. An empty prefix ('') is also allowed.

Contains coercion rule so you can also input:

    Foo-Bar
    Foo-Bar-
    Foo-Bar
    Foo/Bar
    Foo/Bar/
    Foo::Bar

and it will be normalized into `Foo::Bar::`.

_
    match => '\A(?:[A-Za-z_][A-Za-z_0-9]*(::[A-Za-z_0-9]+)*::)?\z',

    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_modprefix',
    ],

    # provide a default completion which is from list of installed perl prefixes
    'x.completion' => 'perl_modprefix',

    examples => [
        {value=>'', valid=>1},
        {value=>'::', valid=>0},
        {value=>'Foo::', valid=>1},
        {value=>'Foo::Bar', valid=>1, validated_value=>'Foo::Bar::'},
        {value=>'Foo::Bar::', valid=>1},
        {value=>'::Foo', valid=>0},
        {value=>'Foo', valid=>1, validated_value=>'Foo::'},
        {value=>'Foo/', valid=>1, validated_value=>'Foo::'},
        {value=>'Foo-', valid=>1, validated_value=>'Foo::'},
    ],

}];

1;
# ABSTRACT:
