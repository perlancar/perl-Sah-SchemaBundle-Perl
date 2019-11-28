package Sah::Schema::perl::modprefix;

# DATE
# VERSION

our $schema = [str => {
    summary => 'Perl module prefix',
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

See also: `perl::modprefix`.

_
    match => '\A(?:[A-Za-z_][A-Za-z_0-9]*(::[A-Za-z_0-9]+)*::)?\z',

    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_modprefix',
    ],

    # provide a default completion which is from list of installed perl prefixes
    'x.completion' => 'perl_modprefix',

}, {}];

1;
# ABSTRACT:
