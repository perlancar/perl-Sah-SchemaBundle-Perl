package Sah::Schema::perl::modname_with_optional_args;

# AUTHORITY
# DATE
# DIST
# VERSION

use Regexp::Pattern::Perl::Module ();

our $schema = [str => {
    summary => 'Perl module name (e.g. Foo::Bar) with optional arguments (e.g. Foo::Bar=arg1,arg2)',
    description => <<'_',

Perl module name with optional arguments which will be used as import arguments,
just like the `-MMODULE=ARGS` shortcut that `perl` provides. Examples:

    Foo
    Foo::Bar
    Foo::Bar=arg1,arg2

See also: `perl::modname`.

_
    match => '\\A(?:' . $Regexp::Pattern::Perl::Module::RE{perl_modname_with_optional_args}{pat} . ')\\z',

    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_modname',
    ],

    # XXX also provide completion for arguments
    'x.completion' => 'perl_modname',

    examples => [
        {value=>'', valid=>0},
        {value=>'Foo::Bar', valid=>1},
        {value=>'Foo::Bar=arg1,arg2', valid=>1},
        {value=>'Foo-Bar=arg1,arg2', valid=>1, validated_value=>'Foo::Bar=arg1,arg2'},
        #{value=>'Foo::Bar=arg1,arg2 foo', valid=>0}, # XXX why fail?
    ],

}, {}];

1;
# ABSTRACT:
